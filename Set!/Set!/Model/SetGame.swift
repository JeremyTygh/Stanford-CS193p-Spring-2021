//
//  SetGame.swift
//  Set!
//
//  Created by Jeremy Tygh on 6/23/21.
//

import Foundation

struct SetGame<Card> where Card: SetCard {
    private(set) var deck: [Card]
    private(set) var cardsInPlay: [Card]
    private(set) var discardPile: [Card]
    private(set) var score = 0
    
    private var selectedCards: [Card] {
        cardsInPlay.filter {$0.isSelected}
    }
    
    // Creates a new SetGame
    init(createDeck: () -> [Card]) {
        let cards = createDeck()
        deck = cards.shuffled()
        cardsInPlay = []
        discardPile = []
        dealCards(dealtCardsSize)
    }
    
    /// Determines if a set is currently selected.
    ///
    /// - Returns: Boolean value representing set selection.
    private func setIsSelected() -> Bool {
        guard selectedCards.count >= setSize else {return false}
        if Card.isSet(card1: selectedCards[0], card2: selectedCards[1], card3: selectedCards[2]) {
            return true
        } else {
            return false
        }
    }
    
    /// Selects a card chosen by the user and changes the state of selected cards to matched or not matched, depending on
    /// count of cards selected and card attributes.
    ///
    /// - Parameter card: A Card that is chosen by the user
    mutating func choose(_ card: Card) {
        if setIsSelected() {
            discardCards()
            toggleCard(card: card)

            //deal cards if count is below 12
            if cardsInPlay.count < dealtCardsSize {
                dealCards()
            }
        } else if selectedCards.count == setSize && !setIsSelected() {
            for selectedCard in selectedCards {
                if let index = cardsInPlay.firstIndex(of: selectedCard) {
                    if cardsInPlay[index] != card {
                        cardsInPlay[index].isSelected = false
                    }
                    cardsInPlay[index].isMatched = nil
                }
            }
            toggleCard(card: card)
        } else {
            toggleCard(card: card)

            if selectedCards.count == setSize && !setIsSelected() {
                indicateMatch(to: false)
                score -= 1
            }
            if setIsSelected() {
                indicateMatch(to: true)
                score += 1
            }
        }
    }
    
    /// Changes state of selected cards to matched or not matched based on input.
    ///
    /// - Parameter match: A Boolean indicating a card to be matched or not matched.
    private mutating func indicateMatch(to match: Bool) {
        for card in selectedCards {
            if let index = cardsInPlay.firstIndex(of: card) {
                cardsInPlay[index].isMatched = match
            }
        }
    }
    
    /// Toggles an inputted card to either selected or not selected.
    ///
    /// - Parameter card: A Card input whose isSelected attribute is to be toggled.
    private mutating func toggleCard(card: Card) {
        for index in cardsInPlay.indices {
            if cardsInPlay[index] == card {
                cardsInPlay[index].isSelected.toggle()
                //print(cardsInPlay[index])
            }
        }
    }
    
    /// Deselects all selected cards and removes them from the cards in play.
    private mutating func discardCards() {
        for _ in selectedCards.indices {
            if let index = cardsInPlay.firstIndex(of: selectedCards.first!) {
                cardsInPlay[index].isSelected = false
                cardsInPlay.remove(at: index)
            }
        }
    }
    
    /// Deals a given amount of cards into play.
    ///
    /// - Parameter quantity: The amount of cards to be dealt. Defaults to 3.
    mutating func dealCards(_ quantity: Int = 3) {
        if setIsSelected() {
            discardCards()
        }
        cardsInPlay.append(contentsOf: deck.prefix(quantity))
        deck = Array(deck.dropFirst(quantity))
    }
    
    //MARK: - Constraints
    private let setSize = 3
    private let dealtCardsSize = 12
    
}


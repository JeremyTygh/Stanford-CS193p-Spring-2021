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
    private(set) var score = 0
    
    private var selectedCards: [Card] {
        cardsInPlay.filter {$0.isSelected}
    }
    
//    init(cards: [Card]) {
//        deck = cards.shuffled()
//        cardsInPlay = []
//    }
    
    init(createDeck: () -> [Card]) {
        let cards = createDeck()
        deck = cards.shuffled()
        cardsInPlay = []
        dealCards(12)
    }
    
    mutating func choose(_ card: Card) {
        guard selectedCards.count < 3 else {return}
        
        for index in cardsInPlay.indices {
            if cardsInPlay[index] == card {
                cardsInPlay[index].isSelected.toggle()
                //print(cardsInPlay[index])
            }
        }
        
        guard selectedCards.count == 3 else {return}
        if Card.isSet(card1: selectedCards[0], card2: selectedCards[1], card3: selectedCards[2]) {
            for _ in selectedCards.indices {
                if let index = cardsInPlay.firstIndex(of: selectedCards.first!) {
                    cardsInPlay[index].isMatched = true
                    cardsInPlay[index].isSelected = false
                    cardsInPlay.remove(at: index)
                }
            }
            score += 1
            if cardsInPlay.count < 12 {
                dealCards()
            }
        } else {
            for index in cardsInPlay.indices {
                if selectedCards.contains(cardsInPlay[index]) {
                    cardsInPlay[index].isSelected = false
                }
            }
            score -= 1
        }
    }
    
    mutating func dealCards(_ quantity: Int = 3) {
        cardsInPlay.append(contentsOf: deck.prefix(quantity))
        deck = Array(deck.dropFirst(quantity))
    }
    
}


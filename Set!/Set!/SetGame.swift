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
    
    private var selectedCards: [Card] {
        cardsInPlay.filter {$0.isSelected}
    }
    
    init(cards: [Card]) {
        deck = cards.shuffled()
        cardsInPlay = []
    }
    
    mutating func choose(_ card: Card) {
        guard selectedCards.count < 3 else {return}
        
        for index in cardsInPlay.indices {
            if cardsInPlay[index] == card {
                cardsInPlay[index].isSelected.toggle()
                print(cardsInPlay[index])
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
            if cardsInPlay.count < 12 {
                dealCards()
            }
        } else {
            for index in cardsInPlay.indices {
                if selectedCards.contains(cardsInPlay[index]) {
                    cardsInPlay[index].isSelected = false
                }
            }
        }
    }
    
    mutating func dealCards(_ quantity: Int = 3) {
        cardsInPlay.append(contentsOf: deck.prefix(quantity))
        deck = Array(deck.dropFirst(quantity))
    }
    
}

//MAYBE PUT IN SEPARATE FILE, EVENTUALLY
protocol SetCard: Identifiable, Equatable {
    associatedtype FeatureA: Equatable
    associatedtype FeatureB: Equatable
    associatedtype FeatureC: Equatable
    associatedtype FeatureD: Equatable
    
    var featureA: FeatureA { get }
    var featureB: FeatureB { get }
    var featureC: FeatureC { get }
    var featureD: FeatureD { get }
    
    var isMatched: Bool {get set}
    var isSelected: Bool {get set}
}

extension SetCard {
    static func isSet(card1: Self, card2: Self, card3: Self) -> Bool {
        let possibleSet = [
            areEquivalent(content1: card1.featureA, content2: card2.featureA, content3: card3.featureA),
            areEquivalent(content1: card1.featureB, content2: card2.featureB, content3: card3.featureB),
            areEquivalent(content1: card1.featureC, content2: card2.featureC, content3: card3.featureC),
            areEquivalent(content1: card1.featureD, content2: card2.featureD, content3: card3.featureD),
        ]
        
        return possibleSet.reduce(true) { $0 && $1 }
    }
    
    static func areEquivalent<Content: Equatable>(content1: Content, content2: Content, content3: Content) -> Bool {
        return (content1 == content2 && content2 == content3) || (content1 != content2 && content2 != content3 && content1 != content3)
    }
}

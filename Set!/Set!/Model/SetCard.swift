//
//  SetCard.swift
//  Set!
//
//  Created by Jeremy Tygh on 7/5/21.
//

import Foundation

/// A type that represents a card with 4 distinct features.
protocol SetCard: Identifiable, Equatable {
    associatedtype FeatureA: Equatable
    associatedtype FeatureB: Equatable
    associatedtype FeatureC: Equatable
    associatedtype FeatureD: Equatable
    
    var featureA: FeatureA { get }
    var featureB: FeatureB { get }
    var featureC: FeatureC { get }
    var featureD: FeatureD { get }
    
    var isMatched: Bool? {get set}
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

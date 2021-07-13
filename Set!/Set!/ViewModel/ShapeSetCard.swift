//
//  ShapeSetCard.swift
//  Set!
//
//  Created by Jeremy Tygh on 7/5/21.
//

import Foundation

struct ShapeSetCard: SetCard, Identifiable, Hashable {
    typealias FeatureA = SetNumber
    typealias FeatureB = SetShape
    typealias FeatureC = SetShading
    typealias FeatureD = SetColor
    
    /*computed variables that are set to the value of those with more readable names*/
    var featureA: SetNumber { setNumber }
    var featureB: SetShape { setShape }
    var featureC: SetShading {setShading }
    var featureD: SetColor { setColor }
    
    var setNumber: SetNumber
    var setShape: SetShape
    var setShading: SetShading
    var setColor: SetColor
    
    var isMatched: Bool?
    var isSelected: Bool = false
    
    var id: Int
    
//    static func generateDeck() -> [Self] {
//        var id = 0
//        var deck = [ShapeSetCard]()
//        for number in SetNumber.allCases {
//            for shape in SetShape.allCases {
//                for shading in SetShading.allCases {
//                    for color in SetColor.allCases {
//                        deck.append(ShapeSetCard(setNumber: number, setShape: shape, setShading: shading, setColor: color, id: id))
//                        id += 1
//                    }
//                }
//            }
//        }
//        return deck
//    }
    
    enum SetNumber: Int, CaseIterable {
        case one = 1, two, three
    }

    enum SetColor: CaseIterable {
        case red, green, purple
    }

    enum SetShape: CaseIterable {
        case diamond, rectangle, oval
    }

    enum SetShading: CaseIterable {
        case solid, striped, open
    }
    
}




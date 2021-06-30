//
//  ShapeSetGame.swift
//  Set!
//
//  Created by Jeremy Tygh on 6/24/21.
//

import Foundation

class ShapeSetGame: ObservableObject {
    @Published var model: SetGame<ShapeSetCard>
    
    init(cards: [ShapeSetCard]) {
        model = SetGame<ShapeSetCard>(cards: cards)
    }
    
    
    func choose(_ card: ShapeSetCard) {
        model.choose(card)
    }
    
    func dealCards(_ quantity: Int = 3) {
        model.dealCards()
    }
    
    func dealFirstCards() {
        model.dealCards(12)
    }
    
    var cardsInPlay: [ShapeSetCard] {
        model.cardsInPlay
    }
    
}

//EVENTUALLY PUT IN SEPARATE FILE
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
    
    var isMatched: Bool = false
    var isSelected: Bool = false
    
    var id: Int
    
    static func generateDeck() -> [Self] {
        var id = 0
        var deck = [ShapeSetCard]()
        for number in SetNumber.allCases {
            for shape in SetShape.allCases {
                for shading in SetShading.allCases {
                    for color in SetColor.allCases {
                        deck.append(ShapeSetCard(setNumber: number, setShape: shape, setShading: shading, setColor: color, id: id))
                        id += 1
                    }
                }
            }
        }
        return deck
    }
    
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



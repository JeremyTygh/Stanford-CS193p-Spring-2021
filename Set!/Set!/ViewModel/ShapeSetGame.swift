//
//  ShapeSetGame.swift
//  Set!
//
//  Created by Jeremy Tygh on 6/24/21.
//

import Foundation

class ShapeSetGame: ObservableObject {
    @Published var model: SetGame<ShapeSetCard>
    
//    init(cards: [ShapeSetCard]) {
//        model = SetGame<ShapeSetCard>(cards: cards)
//    }
    
    init() {
        model = ShapeSetGame.createSetGame()
    }
    
    private static func createSetGame() -> SetGame<ShapeSetCard> {
        return SetGame {
            ShapeSetGame.generateDeck()
        }
    }
    
    private static func generateDeck() -> [ShapeSetCard] {
        var id = 0
        var deck = [ShapeSetCard]()
        for number in ShapeSetCard.SetNumber.allCases {
            for shape in ShapeSetCard.SetShape.allCases {
                for shading in ShapeSetCard.SetShading.allCases {
                    for color in ShapeSetCard.SetColor.allCases {
                        deck.append(ShapeSetCard(setNumber: number, setShape: shape, setShading: shading, setColor: color, id: id))
                        id += 1
                    }
                }
            }
        }
        return deck
    }
    
    var cardsInPlay: [ShapeSetCard] {
        model.cardsInPlay
    }
    
    var deck: [ShapeSetCard] {
        model.deck
    }

    var score: Int {
        model.score
    }
    
    //MARK: - Intents(s)
    
    func resetGame() {
        model = ShapeSetGame.createSetGame()
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

    
}

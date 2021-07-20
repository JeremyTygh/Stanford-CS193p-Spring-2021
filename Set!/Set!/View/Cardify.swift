//
//  Cardify.swift
//  Set!
//
//  Created by Jeremy Tygh on 7/15/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    
    var isMatched: Bool?
    var isSelected: Bool
    
    init(card: ShapeSetCard) {
        rotation = card.isFaceUp ? 0 : 180
        isMatched = card.isMatched
        isSelected = card.isSelected
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation > 90 {
                shape.fill().foregroundColor(Color.blue)
            } else {
                shape.fill().foregroundColor(.white)
                if isMatched != nil {
                    if isMatched == true {
                        shape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(Color.green)
                    } else {
                        shape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(Color.red)
                    }
                } else if isSelected {
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(Color.blue)
                } else {
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(Color.black)
                }
                content
            }

        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
    
}

extension View {
    func cardify(card: ShapeSetCard) -> some View {
        return self.modifier(Cardify(card: card))
    }
}

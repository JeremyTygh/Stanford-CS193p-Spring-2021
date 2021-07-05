//
//  CardView.swift
//  Set!
//
//  Created by Jeremy Tygh on 7/5/21.
//

import SwiftUI

struct CardView: View {
    let card: ShapeSetCard

    var color: Color {
        switch card.setColor {
        case .red:
            return Color.red
        case .green:
            return Color.green
        case.purple:
            return Color.purple
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill().foregroundColor(.white)

                if card.isSelected {
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(Color.blue)
                } else {
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(Color.black)
                }
                VStack {
                    ForEach(0..<card.setNumber.rawValue, id: \.self) { _ in
                        createShape(card: card).padding(4).foregroundColor(color).aspectRatio(2/1, contentMode: .fit)
                    }
                }
                .padding()

            }
        }
    }
}

@ViewBuilder private func createShape(card: ShapeSetCard) -> some View {
    switch card.setShape {
    case .diamond:
        //determineShading(Diamond())
        if card.setShading == .open {
            Diamond().stroke()
        } else if card.setShading == .solid {
            Diamond().fill()
        } else {
            Diamond().fill().opacity(DrawingConstants.shapeOpacity)
        }
    case .rectangle:
        if card.setShading == .open {
            Rectangle().stroke()
        } else if card.setShading == .solid {
            Rectangle().fill()
        } else {
            Rectangle().fill().opacity(DrawingConstants.shapeOpacity)
        }
    case .oval:
        if card.setShading == .open {
            Capsule().stroke()
        } else if card.setShading == .solid {
            Capsule().fill()
        } else {
            Capsule().fill().opacity(DrawingConstants.shapeOpacity)
        }
    }
}

private struct DrawingConstants {
    static let cornerRadius: CGFloat = 10
    static let lineWidth: CGFloat = 3
    static let fontScale: CGFloat = 0.7
    static let shapeOpacity: Double = 0.3
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}

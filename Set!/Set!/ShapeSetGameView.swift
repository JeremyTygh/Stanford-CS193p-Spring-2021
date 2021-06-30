//
//  ContentView.swift
//  Set!
//
//  Created by Jeremy Tygh on 6/23/21.
//

import SwiftUI

struct ShapeSetGameView: View {
    @ObservedObject var game: ShapeSetGame = ShapeSetGame(cards: ShapeSetCard.generateDeck())
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(game.cardsInPlay) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
            .padding(.horizontal)
            .onAppear() {
                game.dealFirstCards()
            }
            
            Button(action: {game.dealCards()}, label: {
                Text("Deal Cards")
            })
            .padding()
        }
        
        
    }
}

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
                } else if card.isMatched{
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(Color.green)
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
            Diamond().fill().opacity(0.3)
        }
    case .rectangle:
        if card.setShading == .open {
            Rectangle().stroke()
        } else if card.setShading == .solid {
            Rectangle().fill()
        } else {
            Rectangle().fill().opacity(0.3)
        }
    case .oval:
        if card.setShading == .open {
            Capsule().stroke()
        } else if card.setShading == .solid {
            Capsule().fill()
        } else {
            Capsule().fill().opacity(0.3)
        }
    }
}

private struct DrawingConstants {
    static let cornerRadius: CGFloat = 10
    static let lineWidth: CGFloat = 3
    static let fontScale: CGFloat = 0.7
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeSetGameView()
    }
}

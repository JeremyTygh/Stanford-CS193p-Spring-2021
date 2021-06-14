//
//  EmojiMemoryGameView.swift
//  Memorize!
//
//  Created by Jeremy Tygh on 5/17/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame = EmojiMemoryGame()
    
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3){ card in
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(0)
            } else {
                CardView(card: card, themeColor: game.themeColor, useGradient: game.useGradient)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
                    .foregroundColor(game.themeColor)
                
            }
        }
        .padding(.horizontal)
        
    }
}


struct CardView: View {
    let card: EmojiMemoryGame.Card
    let themeColor: Color
    let useGradient: Bool
    
    /*
     init(_ givenCard: EmojiMemoryGame.Card) {
     card = givenCard
     }  //this init can allow for a call like: CardView(card). I am not using it, because I have
     // other parameters in the CardView, making labels useful for clarity in a call to this struct.
     */
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(themeColor)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                        .padding(5).opacity(0.5)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    if useGradient {
                        shape.fill(LinearGradient(gradient: Gradient(colors: [themeColor, Color.pink]), startPoint: .top, endPoint: .bottom))
                    } else {
                        shape.fill(themeColor)
                    }
                    
                }
                
            } //function that is an argument to ZStack (content: ), ViewBuilder
        }
        
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
    
    
}

















// "Glue" for Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
//            .preferredColorScheme(.light)
//        EmojiMemoryGameView(game: game)
//            .preferredColorScheme(.dark)
    }
}



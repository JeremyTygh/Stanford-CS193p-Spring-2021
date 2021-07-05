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
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                    .padding(5).opacity(0.5)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
                    
            } //function that is an argument to ZStack (content: ), ViewBuilder
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
    }
    
    
}

















// "Glue" for Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        //game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
//            .preferredColorScheme(.light)
//        EmojiMemoryGameView(game: game)
//            .preferredColorScheme(.dark)
    }
}



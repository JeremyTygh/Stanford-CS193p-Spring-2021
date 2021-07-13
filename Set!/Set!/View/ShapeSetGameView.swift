//
//  ContentView.swift
//  Set!
//
//  Created by Jeremy Tygh on 6/23/21.
//

import SwiftUI

struct ShapeSetGameView: View {
    //    @ObservedObject var game: ShapeSetGame = ShapeSetGame(cards: ShapeSetCard.generateDeck())
    @ObservedObject var game: ShapeSetGame = ShapeSetGame()
    @ Namespace private var dealingNamespace
    
    var body: some View {  
        //NavigationView {
        ZStack {
            Color.orange
                .opacity(0.23)
                .ignoresSafeArea()
            VStack {
                gameBody
                
                HStack {
                    deal
                    Spacer()
                    Text("Score: \(game.score)")
                    Spacer()
                    restart
                }
                .padding(.horizontal)
            }
        
        }
        
        
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cardsInPlay, aspectRatio: 2/3) {card in
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    withAnimation {
                        game.choose(card)
                    }
                }
        }
        .padding(.horizontal)
    }
    var deal: some View {
        Button("Deal Cards") {
            withAnimation {
                game.dealCards()
            }
        }
        .disabled(game.deck.isEmpty)
        .padding(.horizontal)
  
    }
    
    var restart: some View {
        Button("New Game") {
            withAnimation {
                game.resetGame()
            }
        }
        .padding(.horizontal)
    }
    
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeSetGameView()
            .preferredColorScheme(.light)
        ShapeSetGameView()
            .preferredColorScheme(.dark)
    }
}

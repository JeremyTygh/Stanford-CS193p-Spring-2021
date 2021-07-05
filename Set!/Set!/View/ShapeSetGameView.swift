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
    
    
    var body: some View {  
        //NavigationView {
        ZStack {
            Color.orange
                .opacity(0.23)
                .ignoresSafeArea()
            VStack {
                AspectVGrid(items: game.cardsInPlay, aspectRatio: 2/3) {card in
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
                .padding(.horizontal)
                
                HStack {
                    Button(action: {game.dealCards()}, label: {
                        Text("Deal Cards")
                    })
                    .disabled(game.deck.isEmpty)
                    .padding(.horizontal)

                    Spacer()
                    Text("Score: \(game.score)")
                    Spacer()

                    Button(action: {game.resetGame()}, label: {
                        Text("New Game")
                    })
                    .padding(.horizontal)
                }
                .padding(.horizontal)
            }
//                            .toolbar {
//                                ToolbarItemGroup(placement: ToolbarItemPlacement.bottomBar) {
//                                    Button(action: {game.dealCards()}, label: {
//                                        Text("Deal Cards")
//                                    })
//                                    .disabled(game.deck.isEmpty)
//
//                                    Spacer()
//
//                                    Button(action: {game.resetGame()}, label: {
//                                        Text("New Game")
//                                    })
//                                }
//                            }
//                            .navigationBarTitle("")
//                            .navigationBarHidden(true)
        //}
        
        
        }
        
        
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

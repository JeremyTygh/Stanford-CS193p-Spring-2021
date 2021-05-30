//
//  ContentView.swift
//  Memorize!
//
//  Created by Jeremy Tygh on 5/17/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame = EmojiMemoryGame()
    
    var body: some View {
        ScrollView {
            Text("\(viewModel.themeName)").font(.largeTitle)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card, themeColor: viewModel.themeColor, useGradient: viewModel.useGradient)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                        //.foregroundColor(viewModel.themeColor)
                }
            }
            Spacer()
            Text("Score: \(viewModel.scoreOfTheGame)").font(.title).padding()
            Spacer()
            
            Button(action: {viewModel.resetGame()}, label: {
                Text("New Game")
            }).padding()
            
        }
        .padding(.horizontal)
        
        
    }
}


struct CardView: View {
    let card: MemoryGame<String>.Card
    let themeColor: Color
    let useGradient: Bool
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3).foregroundColor(themeColor)
                Text(card.content).font(.largeTitle)
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

















// "Glue" for Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}



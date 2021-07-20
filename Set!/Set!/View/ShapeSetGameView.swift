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
    @Namespace private var dealingNamespace
    @Namespace private var discardingNamespace
    
    var body: some View {  
        //NavigationView {
        ZStack {
            
//            Color.orange
//                .opacity(0.23)
//                .ignoresSafeArea()
            VStack {
                gameBody
                Spacer()
                HStack {
                    deckBody
                    Spacer()
                    discardPileBody
                    Spacer()
                    Text("Score: \(game.score)")
                    Spacer()
                    restart
                }
                .padding(.horizontal)
                
            
            }
        }
        .onAppear() {
            //deal cards with deal animation
            for index in 0..<12 {
                withAnimation(dealAnimation(count: 12, index: index, totalDealDuration: CardConstants.initialTotalDealDuration)) {
                    game.dealCard()
                }
            }
        }
    }
    
    var gameBody: some View {
        //AspectVGrid(items: game.cardsInPlay, aspectRatio: CardConstants.aspectRatio) {card in
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(game.cardsInPlay) { card in
                    CardView(card: card)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .matchedGeometryEffect(id: card.id, in: discardingNamespace)
                        .padding(4)
                        .zIndex(zIndex(of: card))
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            withAnimation {
                                game.choose(card)
                            }
                        }
                }
            }
        }
        //}
        
        .padding(.horizontal)
    }
    
    var discardPileBody: some View {
        ZStack {
            if game.discardPile.isEmpty {
                Color.clear
            } else {
                ForEach(game.discardPile) { card in
                    CardView(card: card)
                        .matchedGeometryEffect(id: card.id, in: discardingNamespace)
                }
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
    }
    
    private func dealAnimation(count: Double, index: Int, totalDealDuration: Double) -> Animation {
        let delay = Double(index) * (totalDealDuration / count)
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: ShapeSetCard) -> Double {
        -Double(game.deck.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.deck) { card in
                //Color.clear.overlay(
                    CardView(card: card)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .zIndex(zIndex(of: card))
                //)
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(Color.blue)
        .onTapGesture {
            for index in 0..<3 {
                withAnimation(dealAnimation(count: 3, index: index, totalDealDuration: CardConstants.totalDealDuration)) {
                    //game.dealCards()
                    game.dealCard()
                }
            }
        }
    }
    
//    var deal: some View {
//        Button("Deal Cards") {
//            //withAnimation {
//                //game.dealCards()
//            //}
//        }
//        .disabled(game.deck.isEmpty)
//        .padding(.horizontal)
//
//    }
    
    var restart: some View {
        Button("New Game") {
            //withAnimation {
                game.resetGame()
            //}
            
            for index in 0..<12 {
                withAnimation(dealAnimation(count: 12, index: index, totalDealDuration: CardConstants.initialTotalDealDuration)) {
                    game.dealCard()
                }
            }
        }
        .padding(.horizontal)
    }
    
}

private struct CardConstants {
    //static let color = Color.red
    static let aspectRatio: CGFloat = 2/3
    static let dealDuration: Double = 0.5
    static let initialTotalDealDuration: Double = 2
    static let totalDealDuration: Double = 0.75
    static let undealtHeight: CGFloat = 90
    static let undealtWidth = undealtHeight * aspectRatio
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeSetGameView()
            .preferredColorScheme(.light)
        ShapeSetGameView()
            .preferredColorScheme(.dark)
    }
}

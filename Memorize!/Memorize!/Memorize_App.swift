//
//  Memorize_App.swift
//  Memorize!
//
//  Created by Jeremy Tygh on 5/17/21.
//

import SwiftUI

@main
struct Memorize_App: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}

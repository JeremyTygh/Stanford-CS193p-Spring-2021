//
//  Set_App.swift
//  Set!
//
//  Created by Jeremy Tygh on 6/23/21.
//

import SwiftUI

@main
struct Set_App: App {
    private let game = ShapeSetGame(cards: ShapeSetCard.generateDeck())

    var body: some Scene {
        WindowGroup {
            ShapeSetGameView(game: game)
        }
    }
}

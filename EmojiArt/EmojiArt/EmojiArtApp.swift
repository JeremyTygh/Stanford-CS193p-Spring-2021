//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Jeremy Tygh on 7/20/21.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    let document = EmojiArtDocument()
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: document)
        }
    }
}

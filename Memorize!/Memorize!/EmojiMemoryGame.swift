//
//  EmojiMemoryGame.swift
//  Memorize!
//
//  Created by Jeremy Tygh on 5/24/21.
//

//import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    //static let emojis = ["🚗", "⛵️", "🚜", "🚲", "🚕", "🚌", "🚁", "🛶", "🛸", "🚒", "🚖", "🛴"].shuffled()
    
    static var themes: [Theme] = [
        Theme(themeName: "Vehicles", setOfEmojiForTheme: ["🚗", "⛵️", "🚜", "🚲", "🚕", "🚌", "🚁", "🛶", "🛸", "🚒", "🚖", "🛴"], numberOfPairs: 6, themeColor: "red"),
        Theme(themeName: "Barn Animals", setOfEmojiForTheme: ["🐔", "🐥", "🐮", "🐷", "🐭", "🐑", "🐖", "🐓"], numberOfPairs: 5, themeColor: "yellow"),
        Theme(themeName: "Faces", setOfEmojiForTheme: ["👳‍♂️", "👩‍🦰", "👨🏽", "🧑🏿‍🦲", "👩🏻‍🦱", "👴", "👱🏽‍♀️", "👶🏻", "👦🏼", "🧔🏻", "👧🏽", "👱🏻‍♂️", "👵🏻", "🧓🏾"], numberOfPairs: 7, themeColor: "blue"),
        Theme(themeName: "Bugs", setOfEmojiForTheme: ["🐝", "🐛", "🦋", "🐞", "🐜", "🦟", "🦗", "🕷", "🦂", "🐌"], numberOfPairs: 8, themeColor: "green"),
        Theme(themeName: "Flags", setOfEmojiForTheme: ["🇳🇴", "🇸🇪", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇺🇸", "🇬🇧", "🇮🇪", "🇨🇦"], numberOfPairs: 7, themeColor: "purple"),
        Theme(themeName: "Halloween", setOfEmojiForTheme: ["👻", "🎃", "🕷", "🦇", "💀"], numberOfPairs: 5, themeColor: "orange")
    ]
    
//    var theme: Theme
//
//
//    init() {
//        let theme = EmojiMemoryGame.themes.randomElement()!
//        self.theme = theme
//        model = EmojiMemoryGame.createMemoryGame(with: theme)
//    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame(with: EmojiMemoryGame.theme)
    
    //@Published private var model: MemoryGame<String>
    
    static var theme = EmojiMemoryGame.themes.randomElement()!
    //static let shuffledSetOfEmojis = theme.setOfEmojiForTheme.shuffled()
    
    static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        let shuffledSetOfEmojis = theme.setOfEmojiForTheme.shuffled()
        
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            //theme.setOfEmojiForTheme[pairIndex]
            shuffledSetOfEmojis[pairIndex]
        }
    }
    
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var scoreOfTheGame: Int {
        model.scoreOfTheGame
    }
    
    var themeName: String {
        EmojiMemoryGame.theme.themeName
    }
    
    var themeColor: Color {
        let stringColor = EmojiMemoryGame.theme.themeColor
        
        switch stringColor {
        case "red":
            return .red
        case "green":
            return .green
        case "blue":
            return .blue
        case "orange":
            return .orange
        case "yellow":
            return .yellow
        case "purple":
            return .purple
        case "pink":
            return .pink
        case "black":
            return .black
        default:
            return .gray
        }
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func resetGame() {
        EmojiMemoryGame.theme = EmojiMemoryGame.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(with: EmojiMemoryGame.theme)
    }
}



//
//  emojiTheme.swift
//  Memorize!
//
//  Created by Jeremy Tygh on 5/27/21.
//

import Foundation

struct Theme<Content> {
    let themeName: String
    var setOfEmojiForTheme: [Content]
    var numberOfPairs: Int?
    var themeColor: String  //made themeColor a String, as this file is technically part of the model,
    //which is supposed to be UI independent.
    var useGradient: Bool
    
    init(themeName: String, setOfEmojiForTheme: [Content], themeColor: String, useGradient: Bool = false) {
        self.themeName = themeName
        self.setOfEmojiForTheme = setOfEmojiForTheme
        self.numberOfPairs = setOfEmojiForTheme.count   //Because it is not declared, this defaults to nil
        self.themeColor = themeColor
        self.useGradient = useGradient
    }
    
    init(themeName: String, setOfEmojiForTheme: [Content], numberOfPairs: Int?, themeColor: String, useGradient: Bool = false) {
        self.themeName = themeName
        self.setOfEmojiForTheme = setOfEmojiForTheme
        let contentCount = setOfEmojiForTheme.count
        self.numberOfPairs = numberOfPairs ?? contentCount //use nil-coalescing operator, as value initiliazed can still be nil. This makes a force unwrap in the viewModel and next line safe.
        if(self.numberOfPairs! > contentCount) {
            self.numberOfPairs = contentCount
        }
        
        //Alternatively: (Not quite as readable in my opinion)
        //self.numberOfPairs = (self.numberOfPairs! < setOfEmojiForTheme.count) ? self.numberOfPairs : setOfEmojiForTheme.count
        self.themeColor = themeColor
        self.useGradient = useGradient
    }
    
}


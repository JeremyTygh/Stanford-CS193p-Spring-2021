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
    var numberOfPairs: Int
    var themeColor: String  //made themeColor a String, as this file is technically part of the model,
    //which is supposed to be UI independent.
}


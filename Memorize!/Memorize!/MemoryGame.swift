//
//  MemoryGame.swift
//  Memorize!
//
//  Created by Jeremy Tygh on 5/24/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp}).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
        //turn cards face down, as getting to else means indexOfTheOneAndOnlyFaceUpCard
        //is nil (none are up, or more than one)
    }
    
    private(set) var scoreOfTheGame: Int = 0  //Initialize to nil. In view, if nil score is --, otherwise, score is an integer.
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    scoreOfTheGame += 2
                } else {
                    if cards[potentialMatchIndex].hasBeenSeen == true {
                        scoreOfTheGame -= 1
                    }
                    if cards[chosenIndex].hasBeenSeen == true {
                        scoreOfTheGame -= 1
                    } //subtracts 1 if the second card selected has been seen when mismatached
                    cards[chosenIndex].hasBeenSeen = true
                    cards[potentialMatchIndex].hasBeenSeen = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
        //print("\(cards)")
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        //cards = cards.shuffled()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var hasBeenSeen = false
        let content: CardContent
        let id: Int
    }
    
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}

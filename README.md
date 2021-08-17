# Stanford-CS193p-Spring-2021
A programming course using Swift and SwiftUI that is offered by Stanford University online for free.

Stanford's CS193p course, Developing Applications for iOS, explains the fundamentals of how to build applications for iPhone and iPad using SwiftUI. Most recently offered in Spring quarter 2021, the lectures were given to Stanford students in an on-line format due to the novel coronavirus pandemic and are now being made available (at least 2 per week) to all via Stanford's YouTube channel.

The course was also offered (and videos made available) in 2020. That version remains archived here, but if you are new to CS193p content, you'll definitely only need to watch the 2021 videos. The only exceptions are Lectures 11 & 12 of 2020 (Enroute) which contains material not covered in 2021.

On this site, you will be able to find materials that were distributed to students during the quarter such as homework assignment write-ups and demo code. Unfortunately, we cannot offer any of the same kind of direct support we gave our students (on-line Q&A and office hours with teaching staff, homework grading, etc.), but the materials posted here should still be helpful in understanding the lectures as you watch. As we emphasize to our students, doing the homework assignments is absolutely essential to learning the material in this course.

SwiftUI is fairly new, having shipped just over a year before this course was taught. Thus it may well be that by the time you are watching it, some of the course's content will already be out of date as updates to SwiftUI occur, requiring some adjustment as you watch. That is normal for new technology.

The material in this course was not developed with the involvement of, nor was it vetted by, anyone at Apple, so it should not be perceived as "the truth" for how to develop using SwiftUI. We've done our best to understand this technology ourselves in the short time it has been out and then share what we've learned. Enjoy!

### *Note: Look at commit history to see code from various assignments/ lectures*

## Assignment I

### Concepts to practice: Xcode 12; Swift 5.4; Writing code in the in-line function that supplies the value of a View's body var; Syntax for passing closures as arguments; Understanding basic building block Views like Text, Button, Spacer, etc.; Putting Views together using VStack, HStack, etc.; Modifying Views; Using @State; Very simple use of Array; Using a Range as a subscript to an Array; The SF Symbols Application; Putting system images into your UI using Image(systemName:); Looking things up in documentation; Int.random(in:); Running your application in different simulators

### Task 1: 
Get the Memorize game working as demonstrated in lectures 1 and 2. Type in all the code. Do not copy/paste from anywhere.

### Task 2: 
You can remove the ⊖ and ⊕ buttons at the bottom of the screen.


### Task 3:
Add a title “Memorize!” to the top of the screen.

```swift
Text("Memorize!").font(.largeTitle)
```

### Task 4 - 9: 
Add at least 3 “theme choosing” buttons to your UI, each of which causes all of the cards to be replaced with new cards that contain emoji that match the chosen theme. You can use Vehicles from lecture as one of the 3 themes if you want to, but you are welcome to create 3 (or more) completely new themes.

The number of cards in each of your 3 themes should be different, but in no case fewer than 8.

The cards that appear when a theme button is touched should be in an unpredictable (i.e. random) order. In other words, the cards should be shuffled each time a theme button is chosen.

The theme-choosing buttons must include an image representing the theme and text describing the theme stacked on top of each other vertically.

The image portion of each of the theme-choosing buttons must be created using an SF Symbol which evokes the idea of the theme it chooses (like the car symbol and the Vehicles theme shown in the Screenshot section below).

The text description of the theme-choosing buttons must use a noticeably smaller font than the font we chose for the emoji on the cards.

```swift
var vehicles: some View {
        Button {
            emojis = ["🚗", "⛵️", "🚜", "🚲", "🚕", "🚌", "🚁", "🛶", "🛸", "🚒", "🚖", "🛴"].shuffled()
            randomNumberEmojis = Int.random(in: 4..<emojis.count)
        } label: {
            VStack {
                Image(systemName: "car")
                Text("Vehicles")
                    .font(.footnote)
            }
        } .padding(.horizontal)
    }
    
    var bugs: some View {
        Button {
            emojis = ["🐝", "🐛", "🦋", "🐞", "🐜", "🦟", "🦗", "🕷", "🦂", "🐌"].shuffled()
            randomNumberEmojis = Int.random(in: 4..<emojis.count)
        } label: {
            VStack {
                Image(systemName: "ant")
                Text("Bugs")
                    .font(.footnote)
            }
        } .padding(.horizontal)
    }
    
    var faces: some View {
        Button {
            emojis = ["👳‍♂️", "👩‍🦰", "👨🏽", "🧑🏿‍🦲", "👩🏻‍🦱", "👴", "👱🏽‍♀️", "👶🏻", "👦🏼", "🧔🏻", "👧🏽", "👱🏻‍♂️", "👵🏻", "🧓🏾"].shuffled()
            randomNumberEmojis = Int.random(in: 4..<emojis.count)
        } label: {
            VStack {
                Image(systemName: "face.smiling")
                Text("Faces")
                    .font(.footnote)
            }
        } .padding(.horizontal)
    }
```

```swift
HStack(alignment: .bottom) {
                vehicles
                Spacer()
                bugs //add theme buttons here
                Spacer()
                faces
            }
            .font(.largeTitle)
            .padding(.horizontal)
```

### Task 10: 
Your UI should work in portrait or landscape on any iPhone. This probably will not require any work on your part (that’s part of the power of SwiftUI), but be sure to experiment with running on different simulators in Xcode to be sure.

## Assignment II

### Concepts to practice: MVVM; Intent functions; init functions; Type Variables (i.e., static); Access Control (i.e., private); Array; Closures

### Task 1: 
Get the Memorize game working as demonstrated in lectures 1 through 4. Type in all the code. Do not copy/paste from anywhere.

### Task 2: 
If you’re starting with your assignment 1 code, remove your theme-choosing buttons and (optionally) the title of your game.

### Task 3: 
Add the formal concept of a “Theme” to your Model. A Theme consists of a name for the theme, a set of emoji to use, a number of pairs of cards to show, and an appropriate color to use to draw the cards.

```swift
struct Theme<Content> {
    let themeName: String
    var setOfEmojiForTheme: [Content]
    var numberOfPairs: Int?
    var themeColor: String  //made themeColor a String, as this file is technically part of the model, which is supposed to be UI independent.
    var useGradient: Bool
    
    ...
    
}
```

### Task 4: 
At least one Theme in your game should show fewer pairs of cards than the number of emoji available in that theme.

```swift
Theme(themeName: "Barn Animals", setOfEmojiForTheme: ["🐔", "🐥", "🐮", "🐷", "🐭", "🐑", "🐖", "🐓"], numberOfPairs: 5, themeColor: "yellow")
```

### Task 5: 
If the number of pairs of emoji to show in a Theme is fewer than the number of emojis that are available in that theme, then it should not just always use the first few emoji in the theme. It must use any of the emoji in the theme. In other words, do not have any “dead emoji” in your code that can never appear in a game.

```swift
static func createMemoryGame(with theme: Theme<String>) -> MemoryGame<String> {
        let shuffledSetOfEmojis = theme.setOfEmojiForTheme.shuffled()
        
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs!) { pairIndex in  //added a force unwrap of numberOfPairs
            //theme.setOfEmojiForTheme[pairIndex]
            shuffledSetOfEmojis[pairIndex]
        }
    }
```
### Task 6 - 7: 
Never allow more than one pair of cards in a game to have the same emoji on it.

If a Theme mistakenly specifies to show more pairs of cards than there are emoji available, then automatically reduce the count of cards to show to match the count of available emoji.

```swift
    //init created within Theme.swift
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
```

### Task 8 - 9: 
Support at least 6 different themes in your game.

A new theme should be able to be added to your game with a single line of code.

```swift
//viewModel (EmojiMemoryGame.swift)
static var themes: [Theme<String>] = [
        Theme(themeName: "Vehicles", setOfEmojiForTheme: ["🚗", "⛵️", "🚜", "🚲", "🚕", "🚌", "🚁", "🛶", "🛸", "🚒", "🚖", "🛴"], numberOfPairs: 6, themeColor: "red"),
        Theme(themeName: "Barn Animals", setOfEmojiForTheme: ["🐔", "🐥", "🐮", "🐷", "🐭", "🐑", "🐖", "🐓"], numberOfPairs: 5, themeColor: "yellow"),
        Theme(themeName: "Faces", setOfEmojiForTheme: ["👳‍♂️", "👩‍🦰", "👨🏽", "🧑🏿‍🦲", "👩🏻‍🦱", "👴", "👱🏽‍♀️", "👶🏻", "👦🏼", "🧔🏻", "👧🏽", "👱🏻‍♂️", "👵🏻", "🧓🏾"], numberOfPairs: Int.random(in: 5..<8), themeColor: "blue", useGradient: true),
        Theme(themeName: "Bugs", setOfEmojiForTheme: ["🐝", "🐛", "🦋", "🐞", "🐜", "🦟", "🦗", "🕷", "🦂", "🐌"], numberOfPairs: 8, themeColor: "green"),
        Theme(themeName: "Flags", setOfEmojiForTheme: ["🇳🇴", "🇸🇪", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇺🇸", "🇬🇧", "🇮🇪", "🇨🇦"], numberOfPairs: 8, themeColor: "purple", useGradient: true),
        Theme(themeName: "Halloween", setOfEmojiForTheme: ["👻", "🎃", "🕷", "🦇", "💀"], themeColor: "orange")
    ]
```

### Task 10 - 13: 
Add a “New Game” button to your UI (anywhere you think is best) which begins a brand new game.

A new game should use a randomly chosen theme and touching the New Game button should repeatedly keep choosing a new random theme.

The cards in a new game should all start face down.

The cards in a new game should be fully shuffled. This means that they are not in any predictable order, that they are selected from any of the emojis in the theme (i.e. Required Task 5), and also that the matching pairs are not all side-by-side like they were in lecture (though they can accidentally still appear side-by-side at random).

```swift
//View
Button(action: {viewModel.resetGame()}, label: {
                Text("New Game")
            }).padding()
```
```swift
//ViewModel
func resetGame() {
        currentTheme = EmojiMemoryGame.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(with: currentTheme)
    }
```

### Task 14: 
Show the theme’s name in your UI. You can do this in whatever way you think looks best.

```swift
//View
Text("\(viewModel.themeName)").font(.largeTitle)
```
```swift
//ViewModel
var themeName: String {
        currentTheme.themeName
    }
```
### Task 15: 
Keep score in your game by penalizing 1 point for every previously seen card that is involved in a mismatch and giving 2 points for every match (whether or not the cards involved have been “previously seen”). See Hints below for a more detailed explanation. The score is allowed to be negative if the user is bad at Memorize.

```swift
//Added hasBeenSeen to Card struct: 

struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var hasBeenSeen: Bool = false
        var content: CardContent
        var id: Int
    }
```
```swift
//Updated scoreOfTheGame throughout choose func
private var indexOfTheOneAndOnlyFaceUpCard: Int?
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
                indexOfTheOneAndOnlyFaceUpCard = nil
                
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                } //turn cards face down, as getting to else means indexOfTheOneAndOnlyFaceUpCard is nil (none are up, or more than one)
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }

//            cards[chosenIndex].hasBeenSeen = true
            cards[chosenIndex].isFaceUp.toggle()
        }
        //print("\(cards)")
    }
```

### Task 16:
Display the score in your UI. You can do this in whatever way you think looks best.

```swift
//View
Text("Score: \(viewModel.scoreOfTheGame)").font(.title).padding()
```
```swift
//ViewModel
var scoreOfTheGame: Int {
        model.scoreOfTheGame
    }
```

### Extra Credit 1: 
When your code creates a Theme, allow it to default to use all the emoji available in the theme if the code that creates the Theme doesn’t want to explicitly specify how many pairs to use. This will require adding an init or two to your Theme struct.

```swift
init(themeName: String, setOfEmojiForTheme: [Content], themeColor: String, useGradient: Bool = false) {
        self.themeName = themeName
        self.setOfEmojiForTheme = setOfEmojiForTheme
        self.numberOfPairs = setOfEmojiForTheme.count   //Because it is not declared, this defaults to nil
        self.themeColor = themeColor
        self.useGradient = useGradient
    }
```

### Extra Credit 2:
Allow the creation of some Themes where the number of pairs of cards to show is not a specific number but is, instead, a random number. We’re not saying that every Theme now shows a random number of cards, just that some Themes can now be created to show a random number of cards (while others still are created to show a specific, pre-determined number of cards).

```swift
Theme(themeName: "Faces", setOfEmojiForTheme: ["👳‍♂️", "👩‍🦰", "👨🏽", "🧑🏿‍🦲", "👩🏻‍🦱", "👴", "👱🏽‍♀️", "👶🏻", "👦🏼", "🧔🏻", "👧🏽", "👱🏻‍♂️", "👵🏻", "🧓🏾"], numberOfPairs: Int.random(in: 5..<8), themeColor: "blue", useGradient: true)
```

### Extra Credit 3: 
Support a gradient as the “color” for a theme. Hint: fill() can take a Gradient as its argument rather than a Color. This is a “learning to look things up in the documentation” exercise.

```swift
//Added useGradient var to Theme struct
var useGradient: Bool
```

```swift
//Within the CardView struct (View) 
if useGradient {
        shape.fill(LinearGradient(gradient: Gradient(colors: [themeColor, Color.pink]), startPoint: .top, endPoint: .bottom))
} else {
        shape.fill(themeColor)
}
```

## Assignment III

### Concepts to practice: All the things from assignments 1 and 2, but from scratch this time; Access Control; Shape; GeometryReader; enum; Closures

### Task 1: 
Implement a game of solo (i.e. one player) Set.

### Task 2-18:
The remainder of the tasks for this assignment can be viewed at the following link: 

https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/assignment_3_0.pdf

<img src="https://user-images.githubusercontent.com/55996049/124500031-080b0800-dd8d-11eb-97d5-71453476aa17.png" width="200">

Please reference the "Set!" folder above to see my implmentation for assignment 3.

## Assignment IV

### Concepts to practice: Animation (implicit and explicit)

### Task 1-5:

Your assignment this week must still play a solo game of Set.

In this version, though, when there is a match showing and the user chooses another card, do not replace the matched cards; instead, discard them (leaving fewer cards in the game).

Add a “deck” and a “discard pile” to your UI. They can be any size you want and you can put them anywhere you want on screen, but they should not be part of your main grid of cards and they should each look like a stack of cards (for example, they should have the same aspect ratio as the cards that are in play).

The deck should contain all the not-yet-dealt cards in the game. They should be “face down” (i.e. you should not be able to see the symbols on them).

The discard pile should contain all the cards that have been discarded from the game (i.e. the cards that were discarded because they matched). These cards should be face up (i.e. you should be able to see the symbols on the last discarded card). Obviously the discard pile is empty when your game starts.

```swift 
    var deckBody: some View {
        ZStack {
            ForEach(game.deck) { card in           
                    CardView(card: card)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(Color.blue)
        .onTapGesture {
            for index in 0..<3 {
                withAnimation(dealAnimation(count: 3, index: index, totalDealDuration: CardConstants.totalDealDuration)) {                 
                    game.dealCard()
                }
            }
            
        }
    }
```
```swift
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
```
Task 6:

Any time matched cards are discarded, they should be animated to “fly” to the discard pile.

```swift
//Within gameBody. Is a modifier for a CardView
.onTapGesture {
    withAnimation {
        game.choose(card)
    }
}
```

Task 7:

You don’t need your “Deal 3 More Cards” button any more. Instead, tapping on the deck should deal 3 more cards.

```swift
.onTapGesture {
    for index in 0..<3 {
        withAnimation(dealAnimation(count: 3, index: index, totalDealDuration: CardConstants.totalDealDuration)) {
            game.dealCard()
        }
     }
}
```

Task 8: 

Whenever more cards are dealt into the game for any reason (including to start the game), their appearance should be animated by “flying them” from the deck into place.
```swift
private func dealAnimation(count: Double, index: Int, totalDealDuration: Double) -> Animation {
        let delay = Double(index) * (totalDealDuration / count)
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
```

Task 9-10:

Note that dealing 3 more cards when a match is showing on the board still should replace those cards and that those matched cards would be flying to the discard pile at the same time as the 3 new cards are flying from the deck (see Extra Credit too).

All the card repositioning and resizing that was required by Required Task 2 in last week’s assignment must now be animated. If your cards from last week never changed their size or position as cards were dealt or discarded, then fix that this week so that they do.

```swift
    mutating func dealCard() {
        if setIsSelected() {
            discardCards()
        }
        if !deck.isEmpty {
            cardsInPlay.append(deck.first!)
            deck = Array(deck.dropFirst())
        }
    }
```

Task 11:

When a match occurs, use some animation (your choice) to draw attention to the match.

```swift
//modifier on shape in CardView
.rotationEffect(Angle.degrees((card.isMatched ?? false) ? 360 : 0))
```

Task 12:

When a mismatch occurs, use some animation (your choice) to draw attention to the mismatch. This animation must be very noticeably different from the animation used to show a match (obviously).
```swift
//modifier on shape in CardView
.shake(animatableData: card.isMatched == false ? 1 : 0)
```

## Assignment V

### Concepts to practice: Gestures 

### Task 1-2:

Download the version of EmojiArt from Lecture 10. Do not break anything that is working there as part of your solution to this assignment.

Support the selection of one or more of the emojis which have been dragged into your EmojiArt document (i.e. you’re selecting the emojis in the document, not the ones in the palette at the bottom). You can show which emojis are selected in any way you’d like. The selection is not persistent (in other words, restarting your app will not preserve the selection).

```swift
    @State private var selectedEmojis = Set<EmojiArtModel.Emoji>()
    
    ForEach(document.emojis) { emoji in
        Text(emoji.text)
            .border(selectedEmojis.contains(matching: emoji) ? Color.black : Color.clear)
            //...
```

### Task 3-4:

Tapping on an unselected emoji should select it.

Tapping on a selected emoji should unselect it.

```swift
ForEach(document.emojis) { emoji in
        Text(emoji.text)
                .onTapGesture {
                    selectedEmojis.toggleMembership(of: emoji)
                }
                //...
```

### Task 5: 

Single-tapping on the background of your EmojiArt (i.e. single-tapping anywhere except on an emoji) should deselect all emoji.

```swift
//in documentBody 
.onTapGesture {
    withAnimation(.linear(duration: 0.1)) {
        selectedEmojis.removeAll()
    }
}
```

### Task 6-7:

Dragging a selected emoji should move the entire selection to follow the user’s finger.

If the user makes a dragging gesture when there is no selection, pan the entire document (i.e., as EmojiArt does in L10).

```swift
// MARK: - Emoji Dragging
    
    @GestureState private var gestureDragOffset: CGSize = CGSize.zero
  
    
    private func dragEmojiGesture(for emoji: EmojiArtModel.Emoji) -> some Gesture {
        DragGesture()
            .updating($gestureDragOffset) { latestDragGestureValue, gestureDragOffset, _ in
                gestureDragOffset = latestDragGestureValue.translation / zoomScale
                for emoji in selectedEmojis {
                    document.moveEmoji(emoji, by: gestureDragOffset)
                }
            }
            .onEnded { finalDragGestureValue in
                let draggedOffset = finalDragGestureValue.translation / zoomScale

                for emoji in selectedEmojis {
                    document.moveEmoji(emoji, by: draggedOffset)                
                }
            }
    }
```

```swift
.gesture(dragEmojiGesture(for: emoji))
```

### Task 8-9: 

If the user makes a pinching gesture anywhere in the EmojiArt document and there is a selection, all of the emojis in the selection should be scaled by the amount of the pinch.

If there is no selection at the time of a pinch, the entire document should be scaled.

```swift
// MARK: - Zooming
    
    @State private var steadyStateZoomScale: CGFloat = 1
    @GestureState private var gestureZoomScale: CGFloat = 1
   
    //....
    
    private func zoomScale(for emoji: EmojiArtModel.Emoji) -> CGFloat{
        if selectedEmojis.contains(matching: emoji) {
            return steadyStateZoomScale * gestureZoomScale
        } else {
            return zoomScale
        }
    }
    
    private func zoomGesture() -> some  Gesture {
        MagnificationGesture()
            .updating($gestureZoomScale) { latestGestureScale, gestureZoomScale, _ in
                gestureZoomScale = latestGestureScale
            }
            .onEnded { gestureScaleAtEnd in
                if selectedEmojis.isEmpty {
                    steadyStateZoomScale *= gestureScaleAtEnd
                } else {
                    for emoji in selectedEmojis {
                        document.scaleEmoji(emoji, by: gestureScaleAtEnd)
                    }
                }
            }
    }
```
### Task 10:

Make it possible to delete emojis from the EmojiArt document. This Required Task is intentionally not saying what user-interface actions should cause this. Be creative and try to find a way to delete the emojis that feels comfortable and intuitive.

```swift
//Model
mutating func removeEmoji(_ emoji: Emoji) {
    emojis.remove(emoji)
}

//ViewModel
func removeEmoji(_ emoji: EmojiArtModel.Emoji) {
    emojiArt.removeEmoji(emoji)
}
```

```swift
//MARK: - Deletion
    
    private func removeEmoji() {
        for emoji in selectedEmojis {
            if document.emojis.contains(matching: emoji) {
                document.removeEmoji(emoji)
                selectedEmojis.remove(emoji)
            }
        }
    }
```

```swift
var palette: some View {
        HStack {
            Spacer()
            Button(action: { removeEmoji() }) {
                Image(systemName: "trash")
                    .font(.system(size: defaultEmojiFontSize))
            }
            .disabled(selectedEmojis.isEmpty ? true : false)
         //....
}
```
### Extra Credit 1: 

Allow dragging unselected emoji separately. In other words, if the user drags an emoji that is part of the selection, move the entire selection (as required above). But if the user drags an emoji that is not part of the selection, then move only that emoji (and do not add it to the selection). You will find that this is a much more comfortable interface for placing emojis. Doing this will very likely require you to have a more sophisticated @GestureState for your drag gesture.

```swift
 private func dragEmojiGesture(for emoji: EmojiArtModel.Emoji) -> some Gesture {
        
        let isSelected = selectedEmojis.contains(matching: emoji)
        
        return DragGesture()
            .updating($gestureDragOffset) { latestDragGestureValue, gestureDragOffset, _ in
                gestureDragOffset = latestDragGestureValue.translation / zoomScale
                
                if isSelected {
                    for emoji in selectedEmojis {
                        document.moveEmoji(emoji, by: gestureDragOffset)
                    }
                } else {
                    document.moveEmoji(emoji, by: gestureDragOffset)
                }
    
            }
            
            //...
  }
            
```

### Extra Credit 2: 

Zooming in to high zoomScales starts to make the emoji look a bit “grainy”. This is because we are using scaleEffect to scale the Text up. These emoji would look quite a bit sharper if we scaled the font size itself. In other words, a font of size 100 is going to look sharper than a font of size 20 with a scaleEffect of 5. But as we learned back in Memorize, trying to zoom a font by just changing its size results in poor animation because the .font modifier is not animatable. See if you can figure out how to make an AnimatableSystemFontModifier that will animate the size of a system font and use that instead of the combination of .font and .scaleEffect we are using now. This ViewModifier can be written in 6 lines of code (not saying you have to do it that efficiently, but just so you know what’s possible).

```swift
struct AnimatableSystemFontModifier: AnimatableModifier {
    var size: CGFloat
    
    func body(content: Content) -> some View {
        content.font(Font.system(size: size))
    }
    
    var animatableData: CGFloat {
        get { size }
        set { size = newValue }
    }
}

extension View {
    func font(animatableWithSize size: CGFloat) -> some View {
        self.modifier(AnimatableSystemFontModifier(size: size))
    }
}
```
```swift
.font(animatableWithSize: fontSize(for: emoji) * zoomScale(for: emoji))

```






# Stanford-CS193p-Spring-2021
A programming course using Swift and SwiftUI that is offered by Stanford University online for free.

Stanford's CS193p course, Developing Applications for iOS, explains the fundamentals of how to build applications for iPhone and iPad using SwiftUI. Most recently offered in Spring quarter 2021, the lectures were given to Stanford students in an on-line format due to the novel coronavirus pandemic and are now being made available (at least 2 per week) to all via Stanford's YouTube channel.

The course was also offered (and videos made available) in 2020. That version remains archived here, but if you are new to CS193p content, you'll definitely only need to watch the 2021 videos. The only exceptions are Lectures 11 & 12 of 2020 (Enroute) which contains material not covered in 2021.

On this site, you will be able to find materials that were distributed to students during the quarter such as homework assignment write-ups and demo code. Unfortunately, we cannot offer any of the same kind of direct support we gave our students (on-line Q&A and office hours with teaching staff, homework grading, etc.), but the materials posted here should still be helpful in understanding the lectures as you watch. As we emphasize to our students, doing the homework assignments is absolutely essential to learning the material in this course.

SwiftUI is fairly new, having shipped just over a year before this course was taught. Thus it may well be that by the time you are watching it, some of the course's content will already be out of date as updates to SwiftUI occur, requiring some adjustment as you watch. That is normal for new technology.

The material in this course was not developed with the involvement of, nor was it vetted by, anyone at Apple, so it should not be perceived as "the truth" for how to develop using SwiftUI. We've done our best to understand this technology ourselves in the short time it has been out and then share what we've learned. Enjoy!

### *Note: Look at commit history to see code from various assignments/ lectures*

## Assignment I

### Task 1: 
Get the Memorize game working as demonstrated in lectures 1 and 2. Type in all the code. Do not copy/paste from anywhere.

### Task 2: 
You can remove the ⊖ and ⊕ buttons at the bottom of the screen.


## Task 3:
Add a title “Memorize!” to the top of the screen.

```swift
Text("Memorize!").font(.largeTitle)
```

## Task 4 - 9: 
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

## Task 10: 
Your UI should work in portrait or landscape on any iPhone. This probably will not require any work on your part (that’s part of the power of SwiftUI), but be sure to experiment with running on different simulators in Xcode to be sure.

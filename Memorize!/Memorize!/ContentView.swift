//
//  ContentView.swift
//  Memorize!
//
//  Created by Jeremy Tygh on 5/17/21.
//

import SwiftUI

struct ContentView: View {
    @State var emojis = ["🚗", "⛵️", "🚜", "🚲", "🚕", "🚌", "🚁", "🛶", "🛸", "🚒", "🚖", "🛴"].shuffled()
    @State var randomNumberEmojis = 12
    
    var body: some View {
        VStack {
            ScrollView {
                Text("Memorize!").font(.largeTitle)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<randomNumberEmojis], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .foregroundColor(.red)
            }
            Spacer()
            HStack(alignment: .bottom) {
                vehicles
                Spacer()
                bugs //add theme buttons here 
                Spacer()
                faces
            }
            .font(.largeTitle)
            .padding(.horizontal)
            
        }
        .padding(.horizontal)
        
    }
    
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
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true //State creates a pointer to a boolean somewhere else in memory. sually dont do this.
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
            
        } //function that is an argument to ZStack (content: ), ViewBuilder
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
    

}

















// "Glue" for Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}

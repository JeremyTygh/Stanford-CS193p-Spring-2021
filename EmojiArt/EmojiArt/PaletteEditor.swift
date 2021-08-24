//
//  PaletteEditor.swift
//  EmojiArt
//
//  Created by Jeremy Tygh on 8/24/21.
//

import SwiftUI

struct PaletteEditor: View {
    @Binding var palette: Palette
    //IMPORTANT:
    //***This binding allows this editor to edit a palette that is somewhere else, namely in the model.****
    //These are never private
    
    var body: some View {
        Form {
            nameSection
            addEmojisSection
            removeEmojiSection
        }
        .navigationTitle("Edit \(palette.name)")
        .frame(minWidth: 300, minHeight: 350)
    }
    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $palette.name)
        }
    }
    
    @State private var emojisToAdd = ""
    
    var addEmojisSection: some View {
        Section(header: Text("Add Emojis")) {
            TextField("", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emojis in
                     addEmojis(emojis)
                }
        }
    }
    
    func addEmojis(_ emojis: String) {
        withAnimation {
            palette.emojis = (emojis + palette.emojis)
                .filter { $0.isEmoji }
                .withNoRepeatedCharacters
        }
    }
    
    var removeEmojiSection: some View {
        Section(header: Text("Remove Emoji")) {
            let emojis = palette.emojis.withNoRepeatedCharacters.map { String($0) }
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                palette.emojis.removeAll(where: { String($0) == emoji})
                            }
                        }
                }
            }
            .font(.system(size: 40))
        }
    }
}

struct PaletteEditor_Previews: PreviewProvider {
    static var previews: some View {
        PaletteEditor(palette: .constant(PaletteStore(named: "Preview").palette(at: 4)))
            .previewLayout(.fixed(width: 300, height: 350))
        PaletteEditor(palette: .constant(PaletteStore(named: "Preview").palette(at: 2)))
            .previewLayout(.fixed(width: 300, height: 600))
    }
}

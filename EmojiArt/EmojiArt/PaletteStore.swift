//
//  PaletteStore.swift
//  EmojiArt
//
//  Created by Jeremy Tygh on 8/19/21.
//

import SwiftUI

struct Palette: Identifiable, Codable, Hashable {
    var name: String
    var emojis: String
    var id: Int
    
    fileprivate init(name: String, emojis: String, id: Int) {
        self.name = name
        self.emojis = emojis
        self.id = id
    }
}

class PaletteStore: ObservableObject {
    let name: String
    
    @Published var palettes = [Palette]() {
        didSet {
            storeInUserDefaults()
        }
    }
    
    private var userDefaultsKey: String {
        "PaletteStore: " + name
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(palettes), forKey: userDefaultsKey)
//        UserDefaults.standard.set(palettes.map { [$0.name, $0.emojis, String($0.id)] }, forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedPalettes = try? JSONDecoder().decode(Array<Palette>.self, from: jsonData) {
            palettes = decodedPalettes
        }
//        if let palettesAsPropertyList = UserDefaults.standard.array(forKey: userDefaultsKey) as? [[String]] {
//            for paletteAsArray in palettesAsPropertyList {
//                if paletteAsArray.count == 3, let id = Int(paletteAsArray[2]), !palettes.contains(where: { $0.id == id}) {
//                    let palette = Palette(name: paletteAsArray[0], emojis: paletteAsArray[1], id: id)
//                    palettes.append(palette)
//                }
//            }
//        }
        
    }
    
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()
        if palettes.isEmpty {
            print("using built-in palettes")
            insertPalette(named: "Vehicles", emojis: "πππππππππππππ²ππβοΈπΈβ΅οΈπΆπ")
            insertPalette(named: "Sports", emojis: "β½οΈππβΎοΈπ₯πΎππππβ³οΈπ₯β·π³")
            insertPalette(named: "Music", emojis: "πΌπ€πΉπ₯π·πΊπΈπͺπ»")
            insertPalette(named: "Animals", emojis: "π’π ππππ¦π¦π¦§ππ¦π¦πͺπ«π¦π¦ππππππ¦ππ¦ππ©π¦?πππ¦©π¦¨πΏπ¦¦")
            insertPalette(named: "Animal Faces", emojis: "πΆπ±π­πΉπ°π¦π»πΌπ¨π―π¦π?π·πΈπ΅πππππ§π€π¦")
            insertPalette(named: "Flora", emojis: "π΅ππ³π΄π±πΏβοΈπππππππΎπ·π₯πΊπΈπ»")
            insertPalette(named: "Weather", emojis: "βοΈπ€βοΈβοΈπ¦π§βπ©π¨βοΈπ¦πβοΈπͺππ₯β‘οΈ")
            insertPalette(named:  "Covid", emojis: "ππ¦ π·π€π€§")
            insertPalette(named: "Faces", emojis: "ππππππππ€£βΊοΈππππππππ₯°ππππ€π§ππ₯³π‘π­π€―π₯Άππ€ ")
        } else {
            print("successfully loaded palettes from UserDefaults: \(palettes)")
        }
    }
    
    // MARK: - Intent
    
    func palette(at index: Int) -> Palette {
        let safeIndex = min(max(index, 0), palettes.count - 1)
        return palettes[safeIndex]
    }
    
    @discardableResult
    func removePalette(at index: Int) -> Int {
        if palettes.count > 1, palettes.indices.contains(index) {
            palettes.remove(at: index)
        }
        return index % palettes.count
    }
    
    func insertPalette(named name: String, emojis: String? = nil, at index: Int = 0) {
        let unique = (palettes.max(by: {$0.id < $1.id })? .id ?? 0) + 1
        let palette = Palette(name: name, emojis: emojis ?? "", id: unique)
        let safeIndex = min(max(index, 0), palettes.count)
        palettes.insert(palette, at: safeIndex)
    }
    
}

//
//  ContentView.swift
//  Set!
//
//  Created by Jeremy Tygh on 6/23/21.
//

import SwiftUI

struct ShapeSetGameModel: View {
    var body: some View {
        
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
            
        }
        
        
        
    }
}

struct CardView: View {
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 10)
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeSetGameModel()
    }
}

//
//  EmojiArtModel.Background.swift
//  EmojiArt
//
//  Created by Jeremy Tygh on 7/20/21.
//

import Foundation

extension EmojiArtModel {
    
    enum Background: Equatable {
        case blank
        case url(URL)
        case imageData(Data)
        
        var url: URL? {
            switch self {
            case .url(let url): return url
            default: return nil
            }
        }
        
        var imageData: Data? {
            switch self {
            case .imageData(let imageData): return imageData
            default: return nil
            }
        }
    }
    
}

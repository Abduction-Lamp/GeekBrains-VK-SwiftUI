//
//  NewsViewModel.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 26.09.2021.
//

import Foundation


final class NewsViewModel: SameDataSetProtocol, Identifiable {

    var id = UUID()
    
    var name:       String
    var avatar:     String
    var text:       String
    var likes:      Int
    var comments:   Int
    var repost:     Int
    var views:      Int
    
    internal init(name: String, avatar: String, text: String) {
        self.name = name
        self.avatar = avatar
        self.text = text
        
        self.likes = Int.random(in: 0...100)
        self.comments = Int.random(in: 0...10)
        self.repost = Int.random(in: 0...5)
        self.views = Int.random(in: 100...9000)
    }
}

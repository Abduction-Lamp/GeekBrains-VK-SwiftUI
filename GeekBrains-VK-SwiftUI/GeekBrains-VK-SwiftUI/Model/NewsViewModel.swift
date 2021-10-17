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
    var avatar:     URL?
    var text:       String
    var likes:      Int
    var comments:   Int
    var repost:     Int
    var views:      Int
    
    internal init(model: NewsViewModel) {
        self.name = model.name
        self.avatar = model.avatar
        self.text = model.text
        
        self.likes = Int.random(in: 0...100)
        self.comments = Int.random(in: 0...10)
        self.repost = Int.random(in: 0...5)
        self.views = Int.random(in: 100...9000)
    }
}

//
//  LikeButtonAndCountView.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 02.11.2021.
//

import SwiftUI


struct LikeButtonAndCountView: View {
    
    private var ownerId: Int
    private var itemId: Int
    private var type: String
    
    private var likes: SocialActivity.Likes?
    
    
    @State var isLike: Bool
    @State var isScaled: Bool = false
    
    
    init(likes: SocialActivity.Likes?, ownerId: Int, itemId: Int, type: String) {
        self.likes = likes
        self.ownerId = ownerId
        self.itemId = itemId
        self.type = type
        
        if likes?.userLikes == 0 {
            self.isLike = false
        } else {
            self.isLike = true
        }
    }
    
    
    var body: some View {
        HStack {
            Image(systemName: isLike ? "heart.fill" : "heart")
                .foregroundColor(.red)
                .scaleEffect(isLike ? 1.5 : 1)
                .onTapGesture {
                    pushLikeButton()
                }
            Text(likes?.count.description ?? " ")
                .lineLimit(1)
        }
    }
    
    
    private func pushLikeButton() {
        let network = NetworkService.instance
        
        if isLike {
            network.likes.delete(ownerId: ownerId, itemId: itemId, type: type) { request in
                if let count = request, count >= 0 {
                    likes?.count = count
                    likes?.userLikes = 0
                    DispatchQueue.main.async {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            isLike = false
                        }
                    }
                }
            }
        } else {
            network.likes.add(ownerId: ownerId, itemId: itemId, type: type) { request in
                if let count = request, count >= 0 {
                    likes?.count = count
                    likes?.userLikes = 1
                    DispatchQueue.main.async {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            isLike = true
                        }
                    }
                }
            }
        }
    }
}

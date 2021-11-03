//
//  SocialActivityPanel.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 26.09.2021.
//

import SwiftUI

struct SocialActivityPanel: View {
    
    private let style = ConstUIStyle.instances
    
    private var likes: SocialActivity.Likes?
    private var comments: SocialActivity.Comments?
    private var reposts: SocialActivity.Reposts?
    private var views: SocialActivity.Views?
    
    private var ownerId: Int
    private var itemId: Int
    private var type: String

    
    init(likes: SocialActivity.Likes?,
         comments: SocialActivity.Comments?,
         reposts: SocialActivity.Reposts?,
         views: SocialActivity.Views?,
         ownerId: Int,
         itemId: Int,
         type: String) {
        
        self.likes = likes
        self.comments = comments
        self.reposts = reposts
        self.views = views
        
        self.ownerId = ownerId
        self.itemId = itemId
        self.type = type
    }
    
    var body: some View {
        HStack {
            LikeButtonAndCountView(likes: likes, ownerId: ownerId, itemId: itemId, type: type)
            
            Spacer()
            
            Image(systemName: "bubble.left")
                .foregroundColor(style.vkBrandColor)
            Text(comments?.count.description ?? " ")
                .lineLimit(1)
            
            Image(systemName: "arrowshape.turn.up.right")
                .foregroundColor(style.vkBrandColor)
                .padding(.leading, 5.0)
            Text(reposts?.count.description ?? " ")
                .lineLimit(1)
            
            Spacer()
            
            Image(systemName: "eye")
                .foregroundColor(.gray)
                .padding(.trailing, 2.0)
            Text(views?.getCountString() ?? " ")
                .lineLimit(1)
                .padding(.trailing, 5.0)
        }
        .padding(.top, 10.0)
    }
}

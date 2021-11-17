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
    
    init(likes: SocialActivity.Likes?, comments: SocialActivity.Comments?, reposts: SocialActivity.Reposts?, views: SocialActivity.Views?) {
        self.likes = likes
        self.comments = comments
        self.reposts = reposts
        self.views = views
    }
    
    var body: some View {
        HStack {
            
            if let isLike = likes?.userLikes {
                if isLike == 0 {
                    Image(systemName: "heart")
                        .foregroundColor(.red)
                        .padding(.leading, 5.0)
                } else {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .padding(.leading, 5.0)
                }
                Text(likes?.count.description ?? " ")
            } else {
                Image(systemName: "heart")
                    .foregroundColor(.red)
                    .padding(.leading, 5.0)
                Text(" ")
            }
            
            Image(systemName: "bubble.left")
                .foregroundColor(style.vkBrandColor)
                .padding(.leading, 5.0)
            Text(comments?.count.description ?? " ")
            Image(systemName: "arrowshape.turn.up.right")
                .foregroundColor(style.vkBrandColor)
                .padding(.leading, 5.0)
            Text(reposts?.count.description ?? " ")
            
            Spacer()
            
            Image(systemName: "eye")
                .foregroundColor(.gray)
                .padding(.trailing, 5.0)
            Text(views?.count.description ?? " ")
                .padding(.trailing, 5.0)
        }
        .padding(.top, 10.0)
    }
}

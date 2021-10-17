//
//  SocialActivityPanel.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 26.09.2021.
//

import SwiftUI

struct SocialActivityPanel: View {
    
    private let style = ConstUIStyle.instances
    
    private var likeCounter:    Int = 0
    private var commentCounter: Int = 0
    private var repostsCounter: Int = 0
    private var viewsCounter:   Int = 0
    
    init(likes: Int, comments: Int, reposts: Int, views: Int) {
        likeCounter = likes
        commentCounter = comments
        repostsCounter = reposts
        viewsCounter = views
    }
    
    var body: some View {
        HStack {
            Image(systemName: "heart")
                .foregroundColor(.red)
                .padding(.leading, 5.0)
            Text("\(likeCounter)")
            Image(systemName: "bubble.left")
                .foregroundColor(style.vkBrandColor)
                .padding(.leading, 5.0)
            Text("\(commentCounter)")
            Image(systemName: "arrowshape.turn.up.right")
                .foregroundColor(style.vkBrandColor)
                .padding(.leading, 5.0)
            Text("\(repostsCounter)")
            
            Spacer()
            
            Image(systemName: "eye")
                .foregroundColor(.gray)
                .padding(.trailing, 5.0)
            Text("\(viewsCounter)")
                .padding(.trailing, 5.0)
        }
        .padding(.top, 10.0)
    }
}

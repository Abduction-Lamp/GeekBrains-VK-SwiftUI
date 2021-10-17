//
//  NewsPrototypeCell.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 26.09.2021.
//

import SwiftUI

struct NewsPrototype: View {
    
    private let style = ConstUIStyle.instances
    private let model: NewsViewModel

    init(model: NewsViewModel) {
        self.model = model
    }
    
    
    
    var body: some View {
        
        VStack(alignment: HorizontalAlignment.center, spacing: 10.0) {
            NamesPrototype(model: model)
            
            Text(model.text)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.leading, 5.0)
            
            SocialActivityPanel(likes: model.likes,
                                comments: model.comments,
                                reposts: model.repost,
                                views: model.views)
                .padding(.bottom, 5.0)
        }
    }
}

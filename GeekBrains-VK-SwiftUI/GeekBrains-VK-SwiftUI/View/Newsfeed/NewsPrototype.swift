//
//  NewsPrototypeCell.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 26.09.2021.
//

import SwiftUI
import Kingfisher


struct NewsPrototype: View {
    
    private let style = ConstUIStyle.instances
    private let model: NewsfeedViewModel

    init(model: NewsfeedViewModel) {
        self.model = model
    }
    
    
    var body: some View {
        
        VStack(alignment: HorizontalAlignment.center, spacing: 10.0) {
            NamesPrototype(model: model)
            
            Text(model.text ?? " ")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.leading, 5.0)
            
            KFImage(model.photo.url)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            SocialActivityPanel(likes: model.likes, comments: model.comments, reposts: model.reposts, views: model.views)
                .padding(.bottom, 5.0)
        }
    }
}

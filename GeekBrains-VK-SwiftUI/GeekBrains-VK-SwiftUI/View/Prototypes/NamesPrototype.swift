//
//  NamesPrototypeCell.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 26.09.2021.
//

import SwiftUI
import Kingfisher

struct NamesPrototype: View {
    
    private var avatar: URL?
    private var name: String

    private let style = ConstUIStyle.instances
    
    init(model: SameDataSetProtocol) {
        avatar = model.avatar
        name = model.name
    }
    
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 10, content: {
            KFImage(avatar)
                .resizable()
                .cancelOnDisappear(true)
                .frame(width: 50.0, height: 50.0)
                .modifier(CircleAndShadow(radius: 25.0, shadowColor: .gray))
                .padding(.leading, 5.0)
                    
            Text(name)
                .bold()
                .lineLimit(1)
                .foregroundColor(style.vkBrandColor)
            
            Spacer()
        })
        .frame(minHeight: 55.0,
               idealHeight: 55.0,
               maxHeight: 55.0,
               alignment: .leading)
    }
}

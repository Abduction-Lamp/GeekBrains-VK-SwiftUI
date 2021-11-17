//
//  NamesPrototypeCell.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 26.09.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct NamesPrototype: View {
    
    private var avatar: URL?
    private var name: String

    private let style = ConstUIStyle.instances
    
    init(model: SameDataSetProtocol) {
        avatar = model.avatar
        name = model.name
    }
    
    @State var isScaled: Bool = false
    
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 10, content: {
            WebImage(url: avatar)
                .resizable()
                .cancelOnDisappear(true)
                .frame(width: 50.0, height: 50.0)
                .modifier(CircleAndShadow(radius: 25.0, shadowColor: .gray))
                .padding(.leading, 5.0)
                .scaleEffect(isScaled ? 1.5 : 1)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        self.isScaled.toggle()
                    }
                    withAnimation(.interpolatingSpring(mass: 0.5,
                                                       stiffness: 200,
                                                       damping: 2,
                                                       initialVelocity: 0)) {
                        self.isScaled.toggle()
                    }
                }
                    
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

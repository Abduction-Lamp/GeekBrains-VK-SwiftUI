//
//  CircleShadowViewModifier.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 26.09.2021.
//

import SwiftUI

struct CircleAndShadow: ViewModifier {
    
    let radius: CGFloat
    let shadowColor: Color
    
    func body(content: Content) -> some View {
        content
            .background(Color.white)
            .cornerRadius(radius)
            .shadow(color: shadowColor, radius: 2, x: 1, y: 1)
    }
}

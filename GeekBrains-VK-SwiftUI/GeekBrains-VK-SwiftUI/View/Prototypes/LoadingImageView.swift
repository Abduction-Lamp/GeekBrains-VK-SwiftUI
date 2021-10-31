//
//  LoadingImageView.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 31.10.2021.
//

import SwiftUI

struct LoadingImageView: View {
    
    @State var opacity1: Double = 0.1
    @State var opacity2: Double = 0.1
    @State var opacity3: Double = 0.1
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 10, height: 10)
                .foregroundColor(Color.gray.opacity(opacity1))
            Circle()
                .frame(width: 10, height: 10)
                .foregroundColor(Color.gray.opacity(opacity2))
            Circle()
                .frame(width: 10, height: 10)
                .foregroundColor(Color.gray.opacity(opacity3))
        }
        .onAppear() {
            withAnimation(.easeInOut(duration: 0.5).repeatForever()) {
                self.opacity1 = 1
            }
            withAnimation(.easeInOut(duration: 0.5).repeatForever().delay(0.3)) {
                self.opacity2 = 1
            }
            withAnimation(.easeInOut(duration: 0.5).repeatForever().delay(0.6)) {
                self.opacity3 = 1
            }
        }
    }
}

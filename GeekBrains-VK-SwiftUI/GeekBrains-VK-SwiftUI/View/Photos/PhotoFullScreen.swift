//
//  PhotoFullScreen.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 19.10.2021.
//

import SwiftUI
import SDWebImageSwiftUI


struct PhotoFullScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    private var url: URL?
    private var isNoPhoto: Bool = false
    
    
    init(url: URL?) {
        self.url = url
        if self.url == nil {
            self.isNoPhoto = true
        } else {
            self.isNoPhoto = false
        }
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            if isNoPhoto {
                Image(systemName: "crown")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
            } else {
                WebImage(url: url)
                    .renderingMode(.original)
                    .resizable()
                    .placeholder {
                        LoadingImageView()
                            .frame(width: 150, height: 150, alignment: .center)
                    }
                    .transition(.fade(duration: 0.25))
                    .scaledToFit()
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button(
                        action: {
                            presentationMode.wrappedValue.dismiss()
                        },
                        label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    )
                    .frame(width: 30, height: 30)
                    .padding(.all, 5)
                    .foregroundColor(.white)
                }
                Spacer()
            }
        }
    }
}

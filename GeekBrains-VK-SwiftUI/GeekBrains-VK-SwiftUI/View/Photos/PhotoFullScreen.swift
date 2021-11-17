//
//  PhotoFullScreen.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 19.10.2021.
//

import SwiftUI
import Kingfisher


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
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
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

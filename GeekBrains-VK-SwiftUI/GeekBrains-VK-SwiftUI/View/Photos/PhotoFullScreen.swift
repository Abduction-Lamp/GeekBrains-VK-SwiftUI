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
    
    private var userPhotosList: [PhotoViewModel]
    @State private var selectedItem: Int
    
    
    init(_ photos: [PhotoViewModel], selected: Int) {
        userPhotosList = photos
        _selectedItem = State(initialValue: selected)
    }
    
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            TabView(selection: $selectedItem) {
                ForEach(userPhotosList) { photo in
                    WebImage(url: photo.getPhotoMaxSize().url)
                        .renderingMode(.original)
                        .resizable()
                        .placeholder {
                            LoadingImageView()
                                .frame(width: 150, height: 150, alignment: .center)
                        }
                        .transition(.fade(duration: 0.25))
                        .scaledToFit()
                        .tag(photo.id)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .background(Color.black)
            
            
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

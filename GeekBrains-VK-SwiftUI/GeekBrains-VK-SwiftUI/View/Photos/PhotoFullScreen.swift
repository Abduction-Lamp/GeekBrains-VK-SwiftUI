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

    @ObservedObject var list: PhotosView
    @State private var selectedItem: Int
    @State private var isLike: Bool = false
    @State private var moveAnimation: Bool = false
    
    
    init(list: ObservedObject<PhotosView>, selected: Int) {
        self._list = list
        self._selectedItem = State(initialValue: selected)
    }
    
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            TabView(selection: $selectedItem) {
                ForEach(list.photos) { photo in
                    ZStack {
                        WebImage(url: photo.getPhotoMaxSize().url)
                            .renderingMode(.original)
                            .resizable()
                            .placeholder {
                                LoadingImageView()
                                    .frame(width: 150, height: 150, alignment: .center)
                            }
                            .transition(.fade(duration: 0.25))
                            .scaledToFit()

                        Image(systemName: "heart.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: isLike ? 150 : 1, height: isLike ? 150 : 1)
                            .foregroundColor(isLike ? .red : .gray)
                            .opacity(moveAnimation ? 1.0 : 0.0)

                    }
                    .tag(photo.id)
                    .onTapGesture(count: 2, perform: {
                        isLike = photo.isLike
                        withAnimation(.easeIn(duration: 0.1)) {
                            moveAnimation.toggle()
                        }
                        withAnimation(.easeOut(duration: 0.9)) {
                            moveAnimation.toggle()
                            isLike.toggle()
                            let _ = list.like(id: selectedItem)
                        }
                    })
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .background(Color.black)
            
            ExitButton()
        }
    }
}


struct ExitButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
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

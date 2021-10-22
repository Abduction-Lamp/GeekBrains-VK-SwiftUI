//
//  FriendPhotosGallery.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 11.10.2021.
//

import SwiftUI
import ASCollectionView
import Kingfisher


struct FriendPhotosGallery: View {
    
    @ObservedObject var list: PhotosView = PhotosView()
    
    @State private var isShowFullScreen: Bool = false
    @State private var model: PhotoViewModel?
    
    var ownerName: String
    var ownerId: Int
    
    
    init(id: Int, name: String) {
        self.ownerId = id
        self.ownerName = name
    }
    
    
    var body: some View {
        ASCollectionView(data: list.photos) { item, _ in
            let url = item.getPhotoMaxSize().url
            Button(
                action: {
                    model = item
                    isShowFullScreen = true
                },
                label: {
                    KFImage(url)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                .cornerRadius(10.0)
        }.layout {
            .grid(layoutMode: .fixedNumberOfColumns(2),
                  itemSpacing: 5,
                  lineSpacing: 5)
        }
        .navigationTitle(ownerName)
        .onAppear() {
            list.fetch(owner: ownerId)
        }
        .fullScreenCover(item: $model) { item in
            PhotoFullScreen(url: item.getPhotoMaxSize().url)
        }
    }
}

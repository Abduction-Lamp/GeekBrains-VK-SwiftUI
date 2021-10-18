//
//  FriendPhotosGallery.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 11.10.2021.
//

import SwiftUI
import ASCollectionView
//import MapKit


struct FriendPhotosGallery: View {
    
    @ObservedObject var list: PhotosView = PhotosView()
    
    var ownerName: String
    var ownerId: Int
    
    init(id: Int, name: String) {
        self.ownerId = id
        self.ownerName = name
    }
    
    
    var body: some View {
        
        ASCollectionView(data: list.photos) { item, _ in
            
            let url = item.getPhotoMaxSize().url    // URL(string: item.sizes.first?.url ?? " ")
            PhotoInCollection(url: url)
        }.layout {
            .grid(layoutMode: .fixedNumberOfColumns(2),
                  itemSpacing: 5,
                  lineSpacing: 5)
        }
        .navigationTitle(ownerName)
        .onAppear() {
            list.fetch(owner: ownerId)
        }
    }
}

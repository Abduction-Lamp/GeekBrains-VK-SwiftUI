//
//  FriendPhotosGallery.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 11.10.2021.
//

import SwiftUI
import SDWebImageSwiftUI


struct FriendPhotosGallery: View {
        
    @ObservedObject var list: PhotosView = PhotosView()
    
    @State private var isShowFullScreen: Bool = false
    @State private var model: PhotoViewModel?
    
    @Binding var mark: MarkNavigtion
    
    var ownerName: String
    var ownerId: Int
    
    private let columns = [
        GridItem(.flexible(minimum: 0, maximum: .infinity)),
        GridItem(.flexible(minimum: 0, maximum: .infinity)),
    ]

    
    
    init(mark: Binding<MarkNavigtion>, id: Int, name: String) {
        self._mark = mark
        self.ownerId = id
        self.ownerName = name
    }
    
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, alignment: .center, spacing: 7)  {
                ForEach(list.photos) { item in
                    let url = item.getPhotoMaxSize().url
                    Button(
                        action: {
                            model = item
                            isShowFullScreen = true
                        },
                        label: {
                            WebImage(url: url)
                                .renderingMode(.original)
                                .resizable()
                                .placeholder {
                                    LoadingImageView()
                                        .frame(width: 150, height: 150, alignment: .center)
                                }
                                .transition(.fade(duration: 0.25))
                                .scaledToFit()
                        })
                        .cornerRadius(10.0)
                }
            }
        }
        .navigationTitle(ownerName)
        .onAppear() {
            list.fetch(owner: ownerId)
        }
        .fullScreenCover(item: $model) { item in
            PhotoFullScreen(list.photos.compactMap { $0 }, selected: item.id)
        }
        .onDisappear() {
            mark = .ViewDisappear
        }
    }
}

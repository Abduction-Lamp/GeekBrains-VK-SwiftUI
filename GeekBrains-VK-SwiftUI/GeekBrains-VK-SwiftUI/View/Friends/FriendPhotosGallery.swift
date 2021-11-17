//
//  FriendPhotosGallery.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 11.10.2021.
//

import SwiftUI
import SDWebImageSwiftUI


struct FriendPhotosGallery: View {
    
    @ObservedObject var list: PhotoViewModelList = PhotoViewModelList()
    
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
                    
                    ZStack {
                        WebImage(url: url)
                            .renderingMode(.original)
                            .resizable()
                            .placeholder {
                                LoadingImageView()
                                    .frame(width: 150, height: 150, alignment: .center)
                            }
                            .transition(.fade(duration: 0.25))
                            .scaledToFit()
                            .cornerRadius(10.0)
                            .onTapGesture {
                                model = item
                                isShowFullScreen = true
                            }
                        
                        VStack {
                            Spacer()
                            HStack {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                                    .padding()
                                    .opacity(item.isLike ? 0.9 : 0.0)
                                Spacer()
                            }
                        }
                    }
                    .onLongPressGesture {
                        let _ = list.like(id: item.id)
                    }
                }
            }
        }
        .navigationTitle(ownerName)
        .onAppear() {
            list.fetch(owner: ownerId)
        }
        .fullScreenCover(item: $model) { item in
            PhotoFullScreen(list: _list, selected: item.id)
        }
        .onDisappear() {
            mark = .ViewDisappear
        }
    }
}

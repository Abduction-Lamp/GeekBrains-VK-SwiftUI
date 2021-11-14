//
//  PhotoViewModel.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 18.10.2021.
//

import Foundation


final class PhotoViewModel: Identifiable {
    
    var id:      Int
    var ownerId: Int
    var date:    TimeInterval?
    var albumId: Int
    var likes:   SocialActivity.Likes?
    var sizes:   [PhotoSizes]
    var text:    String
    
    internal init(model: Photo) {
        self.id = model.id
        self.ownerId = model.ownerId
        self.date = model.date
        self.albumId = model.albumId
        self.likes = model.likes
        self.sizes = model.sizes
        self.text = model.text
    }
    
    public func getPhotoMaxSize() -> (url: URL?, aspectRatio: Float) {
        var index = 0
        var maxSize = 0
        for (i, size) in sizes.enumerated() {
            let greater = max(size.width, size.height)
            if maxSize < greater {
                index = i
                maxSize = greater
            }
        }
        
        let aspectRatio = Float(sizes[index].height) / Float(sizes[index].width)
        return (url: URL(string: sizes[index].url), aspectRatio: aspectRatio)
    }
}


final class PhotosView: ObservableObject {
    
    public var photos: [PhotoViewModel] = []

    public func fetch(owner: Int) {
        let network = NetworkService.instance
        network.photos.get(ownerId: owner) { [weak self] response in
            guard let self = self else { return }
            if let data = response {
                self.photos = data.map { PhotoViewModel(model: $0) }
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }
        }
    }
}


extension PhotoViewModel: Equatable {
    
    static func == (lhs: PhotoViewModel, rhs: PhotoViewModel) -> Bool {
        lhs.id == rhs.id
    }
}

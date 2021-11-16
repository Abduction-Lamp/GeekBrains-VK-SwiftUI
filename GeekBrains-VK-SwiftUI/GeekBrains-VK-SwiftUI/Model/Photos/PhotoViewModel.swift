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
    
    var isLike: Bool {
        if let like = likes?.userLikes,
           like > 0 {
            return true
        }
        return false
    }
    
    
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
    
    public func like(id: Int) -> (isLike: Bool?, count: Int?) {
        if let index = photos.firstIndex(where: { $0.id == id }) {
            let network = NetworkService.instance
            if let isLike = photos[index].likes?.userLikes {
                var countLike: Int? = nil
                if isLike == 0 {
                    network.likes.add(ownerId: photos[index].ownerId, itemId: id, type: "photo") { [weak self] count in
                        guard let self = self else { return }
                        if let count = count {
                            countLike = count
                            self.photos[index].likes?.count = count
                            self.photos[index].likes?.userLikes = 1
                            DispatchQueue.main.async {
                                self.objectWillChange.send()
                            }
                        }
                    }
                    return (isLike: true, count: countLike)
                } else {
                    network.likes.delete(ownerId: photos[index].ownerId, itemId: id, type: "photo") { [weak self] count in
                        guard let self = self else { return }
                        if let count = count {
                            countLike = count
                            self.photos[index].likes?.count = count
                            self.photos[index].likes?.userLikes = 0
                            DispatchQueue.main.async {
                                self.objectWillChange.send()
                            }
                        }
                    }
                    return (isLike: false, count: countLike)
                }
            }
        }
        return (isLike: nil, count: nil)
    }
}


extension PhotoViewModel: Equatable {
    
    static func == (lhs: PhotoViewModel, rhs: PhotoViewModel) -> Bool {
        lhs.id == rhs.id
    }
}

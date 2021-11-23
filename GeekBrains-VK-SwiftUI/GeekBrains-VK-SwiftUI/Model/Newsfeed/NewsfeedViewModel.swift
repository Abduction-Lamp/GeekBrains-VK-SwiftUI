//
//  NewsfeedViewModel.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 26.09.2021.
//

import Foundation


final class NewsfeedViewModel: NamesViewProtocol, Identifiable {
    static var nextFrom: String = ""
    
    var type:       String

    var id:         Int
    var ownerId:    Int
    var name:       String
    var avatar:     URL?
    var date:       TimeInterval

    var likes:      SocialActivity.Likes?
    var comments:   SocialActivity.Comments?
    var reposts:    SocialActivity.Reposts?
    var views:      SocialActivity.Views?

    var text: String?
    
    var photo: (url: URL?, aspectRatio: Float)
    
    
    init(type: String,
         id: Int,
         ownerId: Int,
         name: String,
         avatar: URL?,
         date: TimeInterval,
         likes: SocialActivity.Likes?,
         comments: SocialActivity.Comments?,
         reposts: SocialActivity.Reposts?,
         views: SocialActivity.Views?,
         text: String?,
         photo: (url: URL?, aspectRatio: Float)) {
        
        self.type = type
        self.id = id
        self.ownerId = ownerId
        self.name = name
        self.avatar = avatar
        self.date = date
        self.likes = likes
        self.comments = comments
        self.reposts = reposts
        self.views = views
        self.text = text
        self.photo = photo
    }
}


final class NewsfeedViewModelList: ObservableObject {
    
    public var newsfeed: [NewsfeedViewModel] = []
    
    public func fetch() {
        let network = NetworkService.instance
        network.newsfeed.get(filters: "post", count: 10) { [weak self] response in
            guard let self = self else { return }
            if let data = response {
                DispatchQueue.global().async {
                    self.newsfeed = data.buildNewsfeedList()
                    DispatchQueue.main.async {
                        self.objectWillChange.send()
                    }
                }
            }
        }
    }
}

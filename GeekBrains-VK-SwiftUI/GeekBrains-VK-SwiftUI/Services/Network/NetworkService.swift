//
//  NetworkService.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 16.10.2021.
//

import Foundation

final class NetworkService {
    
    static var instance = NetworkService()

    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        return URLSession(configuration: config)
    }()
    
    
    private init() {
        friends = FriendsRequests(session: session)
        groups = GroupsRequests(session: session)
        newsfeed = NewsfeedRequests(session: session)
    }
    
    
    let friends: FriendsRequests
    let groups: GroupsRequests
    let newsfeed: NewsfeedRequests
}

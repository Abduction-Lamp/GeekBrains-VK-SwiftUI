//
//  VKAuth.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 16.10.2021.
//

import Foundation

final class VKAuth {
    
    static var instance = VKAuth()
    private init() {}
    
    public func buildAuthRequest() -> URLRequest? {
        
        let maskFriendsScope = (1 << 1)
        let maskPhotosScope  = (1 << 2)
        let maskWallScope    = (1 << 13)
        let maskGroupsScope  = (1 << 18)
        let scope = String(maskFriendsScope + maskPhotosScope + maskWallScope + maskGroupsScope)
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: Keychain.instance.app.key),
            URLQueryItem(name: "scope", value: scope),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.130")
        ]
            
        return components.url.map { URLRequest(url: $0) }
    }
}

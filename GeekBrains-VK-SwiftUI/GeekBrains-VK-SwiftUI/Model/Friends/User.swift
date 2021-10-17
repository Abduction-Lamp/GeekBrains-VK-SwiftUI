//
//  User.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 16.10.2021.
//

import Foundation

final class UserService: Decodable {
    var response: ResponseObj
    
    enum CodingKeys: String, CodingKey {
        case response
    }
    
    
    class ResponseObj: Decodable {
        var count: Int
        var items: [User]
        
        enum CodingKeys: String, CodingKey {
            case count
            case items
        }
    }
}


final class User: Codable {
    
    var id: Int = -1
    var firstName: String = ""
    var lastName: String = ""
    var avatar: String = ""
    var birthday: String? = nil
    var nickname: String? = nil
    var domain: String? = nil
    var city: City?
    var country: Country?
    var onlineStatus: Int = -1
    var lastSeen: LastSeen?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case birthday = "bdate"
        case avatar = "photo_50"
        case nickname
        case domain
        case onlineStatus = "online"
        case lastSeen = "last_seen"
        case city
        case country
    }
    
    
    class LastSeen: Codable {
        var platform: Int = 0
        var time: Int64 = 0
        
        enum CodingKeys: String, CodingKey {
            case platform
            case time
        }
    }
        
    class City: Codable {
        var id: Int = -1
        var title: String = ""

        enum CodingKeys: String, CodingKey {
            case id
            case title
        }
    }

    class Country: Codable {
        var id: Int = -1
        var title: String = ""
        
        enum CodingKeys: String, CodingKey {
            case id
            case title
        }
    }
}

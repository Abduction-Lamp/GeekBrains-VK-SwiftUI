//
//  Group.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 17.10.2021.
//

import Foundation


final class GroupService: Decodable {
    var response: ResponseObj
    
    enum CodingKeys: String, CodingKey {
        case response
    }
    
    
    class ResponseObj: Decodable {
        var count: Int
        var items: [Group]
        
        enum CodingKeys: String, CodingKey {
            case count
            case items
        }
    }
}


final class Group: Codable {
    
    var id: Int = -1
    var name: String = ""
    var avatar: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar = "photo_50"
    }
}

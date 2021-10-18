//
//  Photo.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 18.10.2021.
//

import Foundation


protocol PhotoSizesProtocol {
    var width:  Int     { set get }
    var height: Int     { set get }
    var url:    String  { set get }
}


final class PhotoSizes: Codable, PhotoSizesProtocol {
    var width:  Int
    var height: Int
    var type:   String?
    var url:    String
    
    enum CodingKeys: String, CodingKey {
        case width
        case height
        case type
        case url
    }
}


final class PhotoService: Decodable {
    var response: ResponseObj
    
    enum CodingKeys: String, CodingKey {
        case response
    }
    
    
    class ResponseObj: Decodable {
        var count: Int
        var items: [Photo]
        
        enum CodingKeys: String, CodingKey {
            case count
            case items
        }
    }
}

final class Photo: Codable {
    var id:      Int
    var ownerId: Int
    var date:    TimeInterval?
    var albumId: Int
    var likes:   SocialActivity.Likes?
    var sizes:   [PhotoSizes]
    var text:    String
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case date
        case albumId = "album_id"
        case likes
        case sizes
        case text
    }
}

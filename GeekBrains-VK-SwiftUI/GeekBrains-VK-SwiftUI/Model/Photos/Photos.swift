//
//  Photos.swift
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



class PhotoSizes: Codable, PhotoSizesProtocol {
    var width:  Int = 0
    var height: Int = 0
    var type:   String?
    var url:    String = ""
    
    enum CodingKeys: String, CodingKey {
        case width
        case height
        case type
        case url
    }
}

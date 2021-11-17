//
//  SocialActivity.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 18.10.2021.
//

import Foundation


final class SocialActivity {
    
    var likes: Likes?
    var comments: Comments?
    var reposts: Reposts?
    var views: Views?
    
    
    //  MARK:   --
    //
    final class Likes: Codable {
        var count:      Int
        var userLikes:  Int     // 0 = нет, 1(или больше) = да
        var canLike:    Int?
        var canPublish: Int?
        
        enum CodingKeys: String, CodingKey {
            case count
            case userLikes  = "user_likes"
            case canLike    = "can_like"
            case canPublish = "can_publish"
        }
    }
    
    final class Comments: Codable {
        var count:   Int
        var canPost: Int
        
        enum CodingKeys: String, CodingKey {
            case count
            case canPost = "can_post"
        }
    }
    
    final class Reposts: Codable {
        var count: Int
        var userReposted: Int
       
        enum CodingKeys: String, CodingKey {
            case count
            case userReposted = "user_reposted"
        }
    }
    
    final class Views: Codable {
        var count: Int
        
        enum CodingKeys: String, CodingKey {
            case count
        }
        
        public func getCountString() -> String {
            if count >= 1_000_000 {
                return String(format: "%.1fM", Double(count)/1_000_000)
            } else if count >= 10_000 {
                return String(format: "%.1fK", Double(count)/10_000)
            } else if count >= 1000 {
                return String(format: "%.1fK", Double(count)/1000)
            }
            return count.description
        }
    }
}


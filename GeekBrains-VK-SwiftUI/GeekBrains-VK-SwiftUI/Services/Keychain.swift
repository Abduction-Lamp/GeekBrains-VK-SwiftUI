//
//  Keychain.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 16.10.2021.
//

import Foundation

final class Keychain {
    
    static var instance = Keychain()
    private init() {}
    
    let auth = AuthKeychain()
    
    
    
    struct AuthKeychain {
        let token = "VK.Auth.Token"
        let user = "VK.Auth.User.ID"
        let date = "VK.Auth.Date"
    }
}

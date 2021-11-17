//
//  Session.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 16.10.2021.
//

import Foundation

class Session {
    static let instance = Session()
    private init() { }
    
//    static let tokenLifeTime: Double = 86400.0  // 24 часа
    private let key = Keychain.instance
    
    var token: String {
        get {
            UserDefaults.standard.string(forKey: key.auth.token) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key.auth.token)
        }
    }
    
    var user: Int {
        get {
            UserDefaults.standard.integer(forKey: key.auth.user)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key.auth.user)
        }
    }
    
    var date: Double {
        get {
            UserDefaults.standard.double(forKey: key.auth.date)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key.auth.date)
        }
    }
}

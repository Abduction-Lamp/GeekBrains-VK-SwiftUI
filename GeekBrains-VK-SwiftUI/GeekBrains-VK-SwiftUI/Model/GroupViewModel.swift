//
//  GroupViewModel.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 26.09.2021.
//

import Foundation


final class GroupViewModel: SameDataSetProtocol {
    
    var name:   String
    var avatar: String
    
    init(name: String, avatar: String) {
        self.name = name
        self.avatar = avatar
    }
}

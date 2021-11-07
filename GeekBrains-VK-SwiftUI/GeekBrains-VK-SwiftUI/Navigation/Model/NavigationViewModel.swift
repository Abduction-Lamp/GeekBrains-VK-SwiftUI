//
//  NavigationViewModel.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 07.11.2021.
//

import SwiftUI


enum MarkNavigtion {
    case SignInContentView
    case MainTabView
    case FriendPhotosGallery(id: Int, name: String)
}

class NavigationViewModel: ObservableObject {

    @Published var mark: MarkNavigtion = MarkNavigtion.SignInContentView
}

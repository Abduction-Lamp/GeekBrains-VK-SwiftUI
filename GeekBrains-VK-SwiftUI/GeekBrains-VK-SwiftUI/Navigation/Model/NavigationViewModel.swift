//
//  NavigationViewModel.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 07.11.2021.
//

import SwiftUI


public enum MarkNavigtion: Equatable {
    case SignInContentView
    case MainTabView
    case FriendPhotosGallery(id: Int, name: String)
    case SearchAndAddingNewGroup
    case StepBack
    case ViewDisappear
}


class NavigationViewModel: ObservableObject {

    @Published var mark: MarkNavigtion = MarkNavigtion.SignInContentView
}

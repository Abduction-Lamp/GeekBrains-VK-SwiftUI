//
//  AppCoordinator.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 07.11.2021.
//

import UIKit
import Combine
import SwiftUI


class AppCoordinator: Coordinator {

    private(set) var childCoordinator: [Coordinator] = []
    private var cancellables: Set<AnyCancellable> = []
    
    let navigationController: UINavigationController
    var onCompleted: (() -> Void)?
    
    @ObservedObject var navigationViewModel: NavigationViewModel = NavigationViewModel()
    
    
    public init(navigationController: UINavigationController, onCompleted: (() -> Void)? = nil) {
        self.navigationController = navigationController
        self.onCompleted = onCompleted
    }
 
    
    public func start() {
        let rootViewController = UIHostingController(rootView: SignInWebView(mark: $navigationViewModel.mark))
        navigationController.pushViewController(rootViewController, animated: false)
        
        navigationViewModel
            .$mark
            .subscribe(on: RunLoop.main)
            .sink { [weak self] navigationViewModel in
                guard let self = self else { return }
                switch navigationViewModel {
                case .SignInContentView:
                    self.makeSignInWebView()
                case .MainTabView:
                    self.makeMainTabView()
                case .FriendPhotosGallery(let id, let name):
                    self.makeFriendPhotosGalleryView(id: id, name: name)
                }
            }
            .store(in: &cancellables)
    }
    
    
    // MARK: -
    //
    private func makeSignInWebView() {
        self.navigationController.isToolbarHidden = true
        self.navigationController.popToRootViewController(animated: true)
    }
    
    private func makeMainTabView() {
        let mainTabVC = UIHostingController(rootView: MainView(mark: self.$navigationViewModel.mark))
        self.navigationController.isToolbarHidden = true
        self.navigationController.pushViewController(mainTabVC, animated: true)
    }
    
    private func makeFriendPhotosGalleryView(id: Int, name: String) {
        let friendPhotosGalleryVC = UIHostingController(rootView: FriendPhotosGallery(id: id, name: name))
        self.navigationController.isToolbarHidden = false
        self.navigationController.pushViewController(friendPhotosGalleryVC, animated: true)
    }
}

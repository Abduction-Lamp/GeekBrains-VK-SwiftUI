//
//  CoordinatorProtocol.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 07.11.2021.
//

import UIKit


protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController { get }
    var childCoordinator: [Coordinator] { get }
    var onCompleted: (() -> Void)? { get }
    
    func start() 
}


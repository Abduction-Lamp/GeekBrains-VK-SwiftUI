//
//  GroupViewModel.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 26.09.2021.
//

import Foundation


final class GroupViewModel: SameDataSetProtocol, Identifiable {
    var id = UUID()
    var name:   String
    var avatar: URL?
    
    internal init(name: String, urlIcon: URL) {
        self.name = name
        self.avatar = urlIcon
    }
    
    internal init(model: Group) {
        self.name = model.name
        self.avatar = URL(string: model.avatar)
    }
}


final class GroupsView: ObservableObject {

    public var groups: [GroupViewModel] = []
    
    public func fetch() {
        let network = NetworkService.instance
        network.groups.getGroups { [weak self] response in
            guard let self = self else { return }
            if let data = response {
                self.groups = data.map { GroupViewModel(model: $0) }
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }
        }
    }
}

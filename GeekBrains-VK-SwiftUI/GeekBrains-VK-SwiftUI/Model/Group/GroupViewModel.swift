//
//  GroupViewModel.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 26.09.2021.
//

import Foundation


final class GroupViewModel: SameDataSetProtocol, Identifiable {
    var id:     Int
    var name:   String
    var avatar: URL?
    
    internal init(id: Int, name: String, urlIcon: URL) {
        self.id = id
        self.name = name
        self.avatar = urlIcon
    }
    
    internal init(model: Group) {
        self.id = model.id
        self.name = model.name
        self.avatar = URL(string: model.avatar)
    }
}

extension GroupViewModel: Equatable {
    
    static func == (lhs: GroupViewModel, rhs: GroupViewModel) -> Bool {
        lhs.id == rhs.id
    }
}



final class GroupsView: ObservableObject {

    @Published var groups: [GroupViewModel] = []

    
    public func fetch() {
        let network = NetworkService.instance
        network.groups.get { [weak self] response in
            guard let self = self else { return }
            if let data = response {
                DispatchQueue.main.async {
                    self.groups = data.map { GroupViewModel(model: $0) }
                }
            }
        }
    }
    
    public func search(text: String) {
        let network = NetworkService.instance
        let _ = network.groups.search(query: text, offset: 0) { [weak self] response in
            guard let self = self else { return }
            if let data = response {
                DispatchQueue.main.async {
                    self.groups = data.map { GroupViewModel(model: $0) }
                }
            } else {
                DispatchQueue.main.async {
                    self.groups.removeAll()
                }
            }
        }
    }
    
    public func join(group: GroupViewModel) {
        let network = NetworkService.instance
        network.groups.join(id: group.id)
        print("URLSession: User join new group")
        if !self.groups.contains(group) {
            self.groups.append(group)
        }
    }
    
    public func leave(group: GroupViewModel) {
        let network = NetworkService.instance
        network.groups.leave(id: group.id)
        print("URLSession: User leave group")
        if let index = groups.firstIndex(of: group) {
            self.groups.remove(at: index)
        }
    }
}

//
//  FriendViewModel.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 26.09.2021.
//

import SwiftUI


final class FriendViewModel: SameDataSetProtocol, Identifiable {
    
    var id = UUID()
    
    var name:   String
    var avatar: String
    
    internal init(name: String, avatar: String) {
        self.name = name
        self.avatar = avatar
    }
    
    internal init(model: User) {
        self.name = model.firstName + " " + model.lastName
        self.avatar = "0"
    }
}




final class FriendsListWithSections: ObservableObject {
    
    final class ListWithSections: Identifiable {
        let id: UUID
        
        let title: String               //  -- Header
        let items: [FriendViewModel]    //  -- Rows
        
        init(id: UUID, title: String, items: [FriendViewModel]) {
            self.id = id
            self.title = title
            self.items = items
        }
    }
    
    
    public var friends: [ListWithSections] = []
    
    private func makeListWithSection(_ array: [User]) {
        friends.removeAll()
        
        if var title = array.first?.firstName.first {
            var items: [FriendViewModel] = []
            
            for user in array {
                if title == user.firstName.first {
                    items.append(FriendViewModel(model: user))
                } else {
                    friends.append(ListWithSections(id: UUID(), title: String(title), items: items))
                    items.removeAll()
                    if let char = user.firstName.first {
                        title = char
                        items.append(FriendViewModel(model: user))
                    } else {
                        return
                    }
                }
            }
            friends.append(ListWithSections(id: UUID(), title: String(title), items: items))
        }
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    
    public func fetch() {
        let network = NetworkService.instance
        network.getFriends { [weak self] response in
            guard let self = self else { return }
            if let users = response {
                self.makeListWithSection(users)
            }
        }
    }
}

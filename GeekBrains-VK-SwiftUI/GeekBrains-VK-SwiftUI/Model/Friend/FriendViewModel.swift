//
//  FriendViewModel.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 26.09.2021.
//

import SwiftUI


final class FriendViewModel: NamesViewProtocol, Identifiable {
    
    var id: Int
    
    var name:   String
    var avatar: URL?
        
    internal init(model: User) {
        self.id = model.id
        self.name = model.firstName + " " + model.lastName
        self.avatar = URL(string: model.avatar)
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
    
    
    @Published var friends: [ListWithSections] = []
    
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
            self.friends.append(ListWithSections(id: UUID(), title: String(title), items: items))
        }
    }
    
    
    public func fetch() {
        let network = NetworkService.instance
        network.friends.get { [weak self] response in
            guard let self = self else { return }
            if let users = response {
                
                //  FIXME:  Publishing changes from background threads is not allowed;
                //
                //          Publishing changes from background threads is not allowed; make sure to publish values from
                //          the main thread (via operators like receive(on:)) on model updates.
                //
                DispatchQueue.main.async {
                    self.makeListWithSection(users)
                }
            }
        }
    }
}

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
}


//  MARK:   - FriendsListWithSections
///         Кажется, что намудрил, наверника, можно сделать проще
///
struct ListWithSections: Identifiable {
    let id: UUID
    
    let title: String               //  -- Header
    let items: [FriendViewModel]    //  -- Rows
}

final class FriendsListWithSections {
    public var friends: [ListWithSections] = []
    
    init(_ array: [FriendViewModel]) {
        let sortedArray = array.sorted(by: {$0.name < $1.name})
        
        var items: [FriendViewModel] = []
        var title: Character? = sortedArray.first?.name.first
        
        for data in sortedArray {
            if (title == data.name.first) && (data.name.first != nil) {
                items.append(data)
            } else {
                friends.append(ListWithSections(id: UUID(),
                                                title: String(title ?? " "),
                                                items: items))
                title = data.name.first
                items.removeAll()
                items.append(data)
            }
        }
        
        friends.append(ListWithSections(id: UUID(),
                                        title: String(title ?? " "),
                                        items: items))
    }
}

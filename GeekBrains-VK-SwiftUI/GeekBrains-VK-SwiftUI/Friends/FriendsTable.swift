//
//  FriendsTable.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 10.10.2021.
//

import SwiftUI

struct FriendsTable: View {
    
    private var friendsData: [FriendViewModel] = [
        FriendViewModel(name: "Олег Иванов", avatar: "0"),
        FriendViewModel(name: "Дима Зотов", avatar: "1"),
        FriendViewModel(name: "Ира Павлова", avatar: "2"),
        FriendViewModel(name: "Света Ильечёва", avatar: "3"),
        FriendViewModel(name: "Катя Фролова", avatar: "4"),
        FriendViewModel(name: "Юля Бак", avatar: "5"),
        FriendViewModel(name: "Евгений Смирнов", avatar: "6"),
        FriendViewModel(name: "Лев Конышев", avatar: "7"),
        FriendViewModel(name: "Даниил Медведев", avatar: "8"),
        FriendViewModel(name: "Борис Шаипов", avatar: "9"),
        FriendViewModel(name: "Кирилл Александров", avatar: "10")
    ]
    
//    private lazy var friends = FriendsListWithSections(friendsData).friends
    
    var body: some View {
        
        let friends = FriendsListWithSections(friendsData).friends
        
        List {
            ForEach(friends) { section in
                Section(header: Text(section.title)) {
                    ForEach(section.items) { friend in
                        NavigationLink(destination: FriendGallery(model: friend)) {
                            NamesPrototype(model: friend)
                        }
                    }
                }
            }
        }
    }
}

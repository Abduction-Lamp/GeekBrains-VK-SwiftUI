//
//  FriendsTable.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 10.10.2021.
//

import SwiftUI

struct FriendsTable: View {
    
    @ObservedObject var list = FriendsListWithSections()
    
    var body: some View {
    
        List {
            ForEach(list.friends) { section in
                Section(header: Text(section.title)) {
                    ForEach(section.items) { friend in
                        NavigationLink(destination: FriendPhotosGallery(id: friend.id, name: friend.name)) {
                            NamesPrototype(model: friend)
                        }
                    }
                }
            }
        }
        .onAppear(perform: list.fetch)
    }
}

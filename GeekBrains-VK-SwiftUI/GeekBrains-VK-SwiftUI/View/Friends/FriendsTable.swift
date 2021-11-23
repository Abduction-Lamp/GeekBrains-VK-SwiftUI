//
//  FriendsTable.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 10.10.2021.
//

import SwiftUI


struct FriendsTable: View {
    
    @ObservedObject private var list = FriendsListWithSections()
    @State private var isOneLoadData: Bool = true
    
    @Binding var mark: MarkNavigtion
    
    
    var body: some View {
        List {
            ForEach(list.friends) { section in
                Section(header: Text(section.title)) {
                    ForEach(section.items) { friend in
                        NamesPrototype(model: friend)
                            .onTapGesture {
                                self.mark = .FriendPhotosGallery(id: friend.id, name: friend.name)
                            }
                    }
                }
            }
        }
        .onAppear() {
            if isOneLoadData {
                isOneLoadData = false
                list.fetch()
            }
        }
    }
}

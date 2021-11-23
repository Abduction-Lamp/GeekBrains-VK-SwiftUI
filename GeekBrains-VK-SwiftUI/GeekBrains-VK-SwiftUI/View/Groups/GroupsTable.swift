//
//  GroupsTable.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 10.10.2021.
//

import SwiftUI


struct GroupsTable: View {
    
    @ObservedObject var list = GroupsView()
    @Binding var mark: MarkNavigtion
    
    var body: some View {
        List {
            ForEach(list.groups) { group in
                NamesPrototype(model: group)
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    list.leave(group: list.groups[index])
                }
            }
        }
        .listStyle(PlainListStyle())
        .onAppear(perform: list.fetch)
    }
}

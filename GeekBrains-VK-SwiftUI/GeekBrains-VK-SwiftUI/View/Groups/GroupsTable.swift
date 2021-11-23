//
//  GroupsTable.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 10.10.2021.
//

import SwiftUI


struct GroupsTable: View {
    
    @ObservedObject private var list = GroupViewModelList()
    @State private var isOneLoadData: Bool = true
    
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
        .onAppear() {
            if isOneLoadData {
                isOneLoadData = false
                list.fetch()
            }
        }
    }
}

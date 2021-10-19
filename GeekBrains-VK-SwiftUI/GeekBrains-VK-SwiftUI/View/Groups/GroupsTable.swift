//
//  GroupsTable.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 10.10.2021.
//

import SwiftUI

struct GroupsTable: View {
    
    @ObservedObject var list = GroupsView()
    
    var body: some View {
        List(list.groups) { group in
            NamesPrototype(model: group)
        }
        .onAppear(perform: list.fetch)
    }
}

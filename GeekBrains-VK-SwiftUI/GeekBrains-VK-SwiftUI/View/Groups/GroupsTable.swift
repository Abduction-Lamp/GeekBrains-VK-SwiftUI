//
//  GroupsTable.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 10.10.2021.
//

import SwiftUI


protocol NewGroapDelegate {
    func addNewGroup(group: GroupViewModel)  -> Void
}


struct GroupsTable: View {
    
    @ObservedObject var list = GroupsView()
        
    
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
        .navigationBarItems(trailing: makeButtomAdd())
        .navigationBarTitle("Группы", displayMode: .inline)
        .onAppear(perform: list.fetch)
    }
    
    private func makeButtomAdd() -> some View {
        let buttom = NavigationLink(destination: SearchAndAddingNewGroup().environmentObject(list)) {
            Image(systemName: "plus")
        }
        return buttom
    }
}


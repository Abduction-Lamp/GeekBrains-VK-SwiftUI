//
//  NavigationItemsForTabBar.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 10.11.2021.
//

import SwiftUI

struct NavigationItemsForTabBar: ViewModifier {
    
    @Binding var selection: Int
    @Binding var mark: MarkNavigtion
    
    func body(content: Content) -> some View {
        switch selection {
        case 0:
            content
                .navigationBarTitle("Друзья", displayMode: .inline)
                .navigationBarItems(trailing: EmptyView())
        case 1:
            content
                .navigationBarTitle("Группы", displayMode: .inline)
                .navigationBarItems(
                    trailing:
                        Button(action: {
                            mark = .SearchAndAddingNewGroup
                        },
                        label: {
                            Image(systemName: "plus")
                        })
                )
        case 2:
            content
                .navigationBarTitle("Новости", displayMode: .inline)
                .navigationBarItems(trailing: EmptyView())
            
        default:
            content
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(trailing: EmptyView())
        }
    }
}

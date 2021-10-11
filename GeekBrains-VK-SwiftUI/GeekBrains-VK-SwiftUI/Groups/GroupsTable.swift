//
//  GroupsTable.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 10.10.2021.
//

import SwiftUI

struct GroupsTable: View {
    
    private var groups: [GroupViewModel] = [
        GroupViewModel(name: "GeekBrains: iOS - разработка", avatar: "g0"),
        GroupViewModel(name: "Музыка", avatar: "g1"),
        GroupViewModel(name: "Бавария", avatar: "g2"),
        GroupViewModel(name: "Итальянский язык", avatar: "g3"),
        GroupViewModel(name: "Строим дом", avatar: "g4")
    ]
    
    
    var body: some View {
        List(groups) { group in
            NamesPrototype(model: group)
        }
    }
}

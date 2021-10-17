//
//  GroupsTable.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 10.10.2021.
//

import SwiftUI

struct GroupsTable: View {
    
    private var groups: [GroupViewModel] = []
    
    
    var body: some View {
        List(groups) { group in
            NamesPrototype(model: group)
        }
    }
}

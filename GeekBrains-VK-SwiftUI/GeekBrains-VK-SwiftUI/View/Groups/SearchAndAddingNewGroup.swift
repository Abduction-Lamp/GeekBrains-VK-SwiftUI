//
//  SearchAndAddingNewGroup.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 02.11.2021.
//

import SwiftUI


struct SearchAndAddingNewGroup: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var list: GroupsView
    
    @StateObject var searchList = GroupsView()
    
    
    var body: some View {
        VStack {
            SearchBar()
                .environmentObject(searchList)
            
            List(searchList.groups) { group in
                Button(
                    action: {
                        self.list.join(group: group)
                        self.presentationMode.wrappedValue.dismiss()
                    },
                    label: {
                        NamesPrototype(model: group)
                    }
                )
            }
        }
        .navigationBarTitle("Поиск по группам", displayMode: .inline)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

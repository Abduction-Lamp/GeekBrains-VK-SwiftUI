//
//  SearchAndAddingNewGroup.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 02.11.2021.
//

import SwiftUI


struct SearchAndAddingNewGroup: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var searchList = GroupViewModelList()
    @Binding var mark: MarkNavigtion
    
    
    var body: some View {
        VStack {
            SearchBar()
                .environmentObject(searchList)
            
            List(searchList.groups) { group in
                NamesPrototype(model: group)
                    .onTapGesture {
                        searchList.join(group: group)
                        mark = .StepBack
                    }
            }
        }
        .navigationTitle("Поиск по группам")
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .onDisappear() {
            self.mark = .ViewDisappear
        }
    }
}

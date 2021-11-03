//
//  SearchAndAddingNewGroup.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 02.11.2021.
//

import SwiftUI


struct SearchAndAddingNewGroup: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var list = GroupsView()
    
    private var delegate: NewGroapDelegate?
    
    init(delegate: NewGroapDelegate?) {
        self.delegate = delegate
    }
    
    
    var body: some View {
        VStack {
            SearchBar()
                .environmentObject(list)
            List {
                ForEach(list.groups) { group in
                    Button(
                        action: {
                            delegate?.addNewGroup(graup: group)
                            self.presentationMode.wrappedValue.dismiss()
                        },
                        label: {
                            NamesPrototype(model: group)
                        }
                    )
                }
            }
        }
        .navigationBarTitle("Поиск по группам", displayMode: .inline)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

//
//  SearchBur.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 02.11.2021.
//

import SwiftUI
import Combine

struct SearchBar: View {
    
    private let keyboardStatePublisher = Publishers.Merge(
        NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification).map { _ in true },
        NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification).map { _ in false }
    )
    
    @EnvironmentObject var list: GroupsView
    @State var searchText: String = ""

    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(ConstUIStyle.instances.lightGrey)
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("", text: $searchText)
                .foregroundColor(.black)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .onChange(of: searchText, perform: { _ in
                    list.search(text: searchText)
                })
            }
            .padding(.leading, 15)
        }
        .frame(height: 40)
        .cornerRadius(10)
        .padding()
        .onReceive(keyboardStatePublisher) { _ in }
    }
 }

//
//  MainView.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 10.10.2021.
//

import SwiftUI

struct MainView: View {
    @Environment(\.presentationMode) var presentationMode
    
    private let tabs = ["Друзья", "Группы", "Новости"]
    
    @State private var selectedTab = 0

    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView { FriendsTable() }
            .tabItem {
                Image(systemName: "person.3.fill")
                Text(tabs[0])
            }
            
            NavigationView { GroupsTable() }
            .tabItem {
                Image(systemName: "bookmark.circle.fill")
                Text(tabs[1])
            }
                
            NavigationView {  NewsTable() }
            .tabItem {
                Image(systemName: "newspaper")
                Text(tabs[0])
            }
        }
    }
}

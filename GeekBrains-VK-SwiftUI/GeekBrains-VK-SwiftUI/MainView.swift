//
//  MainView.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 10.10.2021.
//

import SwiftUI

struct MainView: View {
    
    @Binding var mark: MarkNavigtion
    @State private var selectedTab: Int = 0
    
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            FriendsTable(mark: $mark)
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Друзья")
                }
                .tag(0)
            
            GroupsTable(mark: $mark)
                .tabItem {
                    Image(systemName: "bookmark.circle.fill")
                    Text("Группы")
                }
                .tag(1)
            
            NewsTable()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("Новости")
                }
                .tag(2)
        }
        .modifier(NavigationItemsForTabBar(selection: $selectedTab, mark: $mark))
        .navigationBarBackButtonHidden(true)
    }
}

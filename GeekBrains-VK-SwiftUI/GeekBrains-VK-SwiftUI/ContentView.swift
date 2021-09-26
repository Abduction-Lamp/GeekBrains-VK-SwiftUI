//
//  ContentView.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 11.09.2021.
//

import SwiftUI
import Combine


struct ContentView: View {
    
    let friend = FriendViewModel(name: "Иван Иванов", avatar: "superman")
    let group = GroupViewModel(name: "GeekBrains: iOS - разработка", avatar: "artificial-intelligence")
    let new = NewsViewModel(name: "Новости: Толстой", avatar: "launch")
    
    
    var body: some View {
        
//        SignIn()
        ScrollView(.vertical, showsIndicators: false) {
            NamesPrototype(model: friend)
            NamesPrototype(model: group)
            NewsPrototype(model: new)
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

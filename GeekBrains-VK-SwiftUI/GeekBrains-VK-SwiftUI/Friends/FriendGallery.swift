//
//  FriendGallery.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 11.10.2021.
//

import SwiftUI

struct FriendGallery: View {
    
    private let name: String
    
    init(model: FriendViewModel) {
        name = model.name
    }
    
    var body: some View {
        VStack {
            Text("Галлерея")
            Text(name)
        }
    }
}

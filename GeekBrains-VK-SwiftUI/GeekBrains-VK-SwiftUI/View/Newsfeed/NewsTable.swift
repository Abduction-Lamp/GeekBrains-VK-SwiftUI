//
//  NewsTable.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 10.10.2021.
//

import SwiftUI

struct NewsTable: View {
    
    @ObservedObject var list = NewsView()
    
    var body: some View {
        List(list.newsfeed) { news in
            NewsPrototype(model: news)
        }
        .onAppear() {
            list.fetch()
        }
    }
}

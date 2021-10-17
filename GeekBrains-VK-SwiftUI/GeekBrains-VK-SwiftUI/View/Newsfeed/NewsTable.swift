//
//  NewsTable.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 10.10.2021.
//

import SwiftUI

struct NewsTable: View {
    
    var body: some View {
        List(newsfeed) { news in
            NewsPrototype(model: news)
        }
    }
    
    
    
    //  MARK:
    //
    private var newsfeed: [NewsViewModel] = []
}

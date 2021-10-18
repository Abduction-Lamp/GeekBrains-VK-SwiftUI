//
//  PhotoInCollection.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 18.10.2021.
//

import SwiftUI
import Kingfisher


struct PhotoInCollection: View {
    
    private var urlPhoto: URL?
    private var isNoPhoto: Bool = false
    
    init(url: URL?) {
        if let url = url {
            self.urlPhoto = url
        } else {
            self.isNoPhoto = true
        }
    }

    init() {
        self.isNoPhoto = true
    }
    
    
    var body: some View {
        if isNoPhoto {
            Image(systemName: "crown")
                .resizable()
                .background(Color.gray)
        } else {
            KFImage(urlPhoto)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

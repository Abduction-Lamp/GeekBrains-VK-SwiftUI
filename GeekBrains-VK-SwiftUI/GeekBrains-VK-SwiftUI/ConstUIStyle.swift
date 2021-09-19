//
//  ConstUIStyle.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 19.09.2021.
//

import SwiftUI

struct ConstUIStyle {
    static var instances = ConstUIStyle()
    
    private init() {}
    
    let vkBrandColor = Color.init(red: 33/255, green: 111/255, blue: 243/255)
}

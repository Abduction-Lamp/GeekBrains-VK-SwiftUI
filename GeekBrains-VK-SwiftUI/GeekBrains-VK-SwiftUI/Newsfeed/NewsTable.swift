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
    private var newsfeed: [NewsViewModel] = [
        NewsViewModel(name: "Новости: Л. Н. Толстой",
                      avatar: "launch",
                      text: """
            Все счастливые семьи похожи друг на друга, каждая несчастливая семья несчастлива по-своему.
            Все смешалось в доме Облонских. Жена узнала, что муж был в связи с бывшею в их доме француженкою-гувернанткой, и объявила мужу, что не может жить с ним в одном доме. Положение это продолжалось уже третий день и мучительно чувствовалось и самими супругами, и всеми членами семьи, и домочадцами. Все члены семьи и домочадцы чувствовали, что нет смысла в их сожительстве и что на каждом постоялом дворе случайно сошедшиеся люди более связаны между собой, чем они, члены семьи и домочадцы Облонских. Жена не выходила из своих комнат, мужа третий день не было дома. Дети бегали по всему дому, как потерянные; англичанка поссорилась с экономкой и написала записку приятельнице, прося приискать ей новое место; повар ушел еще вчера со двора, во время обеда; черная кухарка и кучер просили расчета.
            """),
        
        NewsViewModel(name: "Swift",
                      avatar: "swift",
                      text: """
            Swift includes features that make code easier to read and write, while giving the developer the control needed in a true systems programming language. Swift supports inferred types to make code cleaner and less prone to mistakes, and modules eliminate headers and provide namespaces. Memory is managed automatically, and you don’t even need to type semi-colons. Swift also borrows from other languages, for instance named parameters brought forward from Objective-C are expressed in a clean syntax that makes APIs in Swift easy to read and maintain.
            """),

        NewsViewModel(name: "Physic",
                      avatar: "physics",
                      text: """
            In Tesla's Lab. 1894. Mark Twain holds Tesla's vacuum lamp, powered by a loop of wire that gets electromagnetic energy from a Tesla coil. Tesla's face is in the background.
            """)
    ]
}

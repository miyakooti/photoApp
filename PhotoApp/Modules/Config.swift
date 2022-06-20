//
//  Config.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/19.
//

import Foundation

struct Config {
    
    static let apiKey = "apiKeyを入力してください"
    static let searchKey = "searchKeyを入力してください"
    
    
    
    static let isDebug = false
    
    static let testData = [
        OshiCollection(listName: "影山優香", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/844/02450174314bb3f596ce3254d0fb3/400_320_102400.jpg")]),
        OshiCollection(listName: "齊藤京子2", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),
        OshiCollection(listName: "影山優香", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/844/02450174314bb3f596ce3254d0fb3/400_320_102400.jpg")]),
        OshiCollection(listName: "加藤志穂", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/730/13682c011735c92c06afa89fea784/400_320_102400.jpg")]),
        OshiCollection(listName: "齊藤京子5", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),
        OshiCollection(listName: "齊藤京子6", items: []),
        OshiCollection(listName: "齊藤京子7", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),
        OshiCollection(listName: "齊藤京子8", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),
        OshiCollection(listName: "齊藤京子9", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),
        OshiCollection(listName: "齊藤京子10", items: [ListItem(url: "https://cdn.hinatazaka46.com/images/14/691/64f4b4d860bc36d8d436cc4d4d2db/1000_1000_102400.jpg")]),

    ]
    
    static let defaultListIconImageUrl = "https://raw.githubusercontent.com/miyakooti/kousuke_portofolio/master/img/person-fill.png"
}

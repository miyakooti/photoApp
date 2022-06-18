//
//  imageCollection.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/18.
//

import Foundation

struct ImageCollection {
    let listName: String
    let items: [ListItem]
}

struct ListItem {
    let url: String
}

//
//  imageCollection.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/18.
//

import Foundation

struct ImageCollection: Codable {
    let listName: String
    let items: [ListItem]
}

struct ListItem: Codable {
    let url: String
}

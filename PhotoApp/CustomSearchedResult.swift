//
//  CustomSearchedResult.swift
//  PhotoApp
//
//  Created by Arai Kousuke on 2022/06/18.
//

import Foundation

struct CustomSearchedResult: Codable {
    let items: [Item]
}

struct Item: Codable {
    let link: String
}

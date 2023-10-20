//
//  Category.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 25/09/23.
//

import Foundation

struct Category: Codable, Equatable, Hashable, Identifiable {
    let id: String
    let name: String
    let thumbnailURL: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case thumbnailURL = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}

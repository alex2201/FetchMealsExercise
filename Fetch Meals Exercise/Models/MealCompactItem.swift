//
//  MealPreview.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 22/09/23.
//

import Foundation

struct MealCompactItem: Codable, Identifiable, Hashable {
    let name: String
    let thumbnail: String
    let id: String
    
    var thumbnailUrl: URL? {
        URL(string: thumbnail)
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case thumbnail = "strMealThumb"
        case id = "idMeal"
    }
}

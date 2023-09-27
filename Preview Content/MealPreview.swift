//
//  MealPreview.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 25/09/23.
//

import Foundation

struct MealPreview {
    static let preview = {
        let fileUrl = Bundle.main.url(forResource: "Meal", withExtension: ".json")!
        let data = try! Data(contentsOf: fileUrl)
        return try! JSONDecoder().decode(Meal.self, from: data)
    }()
}

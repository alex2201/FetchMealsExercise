//
//  DessertListPreview.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 25/09/23.
//

import Foundation

struct DessertListPreview {
    static let dessertList = {
        let fileUrl = Bundle.main.url(forResource: "DessertList", withExtension: ".json")!
        let data = try! Data(contentsOf: fileUrl)
        return try! JSONDecoder().decode([MealCompactItem].self, from: data)
    }()
}

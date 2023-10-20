//
//  Meal.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 22/09/23.
//

import Foundation

struct Ingredient: Codable, Hashable, Identifiable {
    let id: UUID
    let name: String
    let measure: String
}

struct Meal: Decodable, Identifiable, Hashable {
    let id: String
    let name: String
    let drinkAlternate: String?
    let category: String
    let area: String
    let instructions: String
    let thumbnail: String
    let tags: String?
    let youtubeLink: String
    let ingredients: [Ingredient]
    
    var thumbnailUrl: URL? {
        URL(string: thumbnail)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case drinkAlternate = "strDrinkAlternate"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case thumbnail = "strMealThumb"
        case tags = "strTags"
        case youtubeLink = "strYoutube"
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
        case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
        case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        drinkAlternate = try container.decodeIfPresent(String.self, forKey: .drinkAlternate)
        category = try container.decode(String.self, forKey: .category)
        area = try container.decode(String.self, forKey: .area)
        instructions = try container.decode(String.self, forKey: .instructions)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
        tags = try container.decodeIfPresent(String.self, forKey: .tags)
        youtubeLink = try container.decode(String.self, forKey: .youtubeLink)

        // Create an array of Ingredient objects
        var ingredientsArray = [Ingredient]()

        for index in 1...20 {
            if let ingredient = try? container.decode(String.self, forKey: .init(stringValue: "strIngredient\(index)")!),
               let measure = try? container.decode(String.self, forKey: .init(stringValue: "strMeasure\(index)")!),
               !ingredient.isEmpty && !measure.isEmpty {
                let ingredientObject = Ingredient(id: UUID(), name: ingredient, measure: measure)
                ingredientsArray.append(ingredientObject)
            }
        }

        ingredients = ingredientsArray
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Meal, rhs: Meal) -> Bool {
        lhs.id == rhs.id
    }
}


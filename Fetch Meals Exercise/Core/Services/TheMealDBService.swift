//
//  TheMealDBService.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 25/09/23.
//

import Foundation

struct TheMealDBService {
    static let shared = TheMealDBService()
    private let baseURL = URL(string: "https://www.themealdb.com/api/json/v1/1/")!
    private let httpRequest = HttpRequest()
    
    private init() {}
    
    func getCategoryList() async -> [Category] {
        let url = baseURL.appending(path: "categories.php")
        
        do {
            let response: RequestResponse<Category> = try await httpRequest.execute(request: URLRequest(url: url))
            return response.data
        } catch {
            debugPrint(error)
            return []
        }
    }
    
    func getMealList(forCategory category: Category) async -> [MealCompactItem] {
        var url = baseURL.appending(path: "filter.php")
        url.append(queryItems: [URLQueryItem(name: "c", value: category.name)])
        
        do {
            let response: RequestResponse<MealCompactItem> = try await httpRequest.execute(request: URLRequest(url: url))
            return response.data
        } catch {
            debugPrint(error)
            return []
        }
    }
    
    func getMealRecipe(for meal: MealCompactItem) async -> Meal? {
        var url = baseURL.appending(path: "lookup.php")
        url.append(queryItems: [URLQueryItem(name: "i", value: meal.id)])
        
        do {
            let response: RequestResponse<Meal> = try await httpRequest.execute(request: URLRequest(url: url))
            return response.data.first
        } catch {
            debugPrint(error)
            return nil
        }
    }
    
    struct RequestResponse<T: Decodable>: Decodable {
        enum CodingKeys: String, CodingKey {
            case meals
            case categories
            case data
        }
        
        let data: [T]
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            if let meals = try? container.decode([T].self, forKey: .meals) {
                data = meals
            } else if let categories = try? container.decode([T].self, forKey: .categories) {
                data = categories
            } else {
                throw DecodingError.dataCorruptedError(forKey: CodingKeys.data, in: container, debugDescription: "Unable to decode data.")
            }
        }
    }
}

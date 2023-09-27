//
//  HttpRequest.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 22/09/23.
//

import Foundation

struct HttpRequest {
    func execute<T: Decodable>(request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw HttpRequestError.requestError(errorCode: httpResponse.statusCode)
        }
        
        return try await parseData(to: T.self, from: data)
    }
    
    func parseData<T: Decodable>(to type: T.Type, from data: Data) async throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            debugPrint(error)
            throw HttpRequestError.decodingError
        }
    }
}

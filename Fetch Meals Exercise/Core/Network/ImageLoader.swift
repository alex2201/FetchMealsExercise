//
//  ImageLoader.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 25/09/23.
//

import Foundation
import UIKit

protocol ImageLoader {
    func fetchImage(from url: URL) async -> UIImage?
}

class HttpImageLoader: ImageLoader {
    func fetchImage(from url: URL) async -> UIImage? {
        var result: UIImage? = nil
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let httpResponse = response as! HTTPURLResponse
            
            guard (200...299).contains(httpResponse.statusCode) else {
                debugPrint(httpResponse)
                return nil
            }
            
            result = UIImage(data: data)
        } catch {
            debugPrint(error)
        }
        
        return result
    }
}

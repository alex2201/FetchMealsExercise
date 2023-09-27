//
//  AppConfig.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 26/09/23.
//

import Foundation

class AppConfig {
    static let shared = AppConfig()
    private lazy var config: [String: Any] = self.load()
    
    private init() {}
    
    private func load() -> [String: Any] {
        guard let fileUrl = Bundle.main.path(forResource: "AppConfig", ofType: "json"),
              let data =  try? Data(contentsOf: URL(fileURLWithPath: fileUrl)) else {
            return [:]
        }
        guard let config = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return [:]
        }
        
        return config
    }
    
    func getConfig<T>(withKey key: String) -> T? {
        guard let value = config[key] else {
            return nil
        }
        return value as? T
    }
}

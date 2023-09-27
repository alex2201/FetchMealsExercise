//
//  DefaultImageCache.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 26/09/23.
//

import UIKit

class DefaultImageCache: ImageCache {
    typealias Key = NSURL
    
    static let shared = DefaultImageCache()
    
    private let cache = NSCache<Key, UIImage>()
    private let loader: ImageLoader
    
    private init(loader: ImageLoader = HttpImageLoader()) {
        self.loader = loader
    }
    
    func getImage(usingKey key: NSURL) async -> UIImage? {
        var result: UIImage
        
        if let image = cache.object(forKey: key) {
            result = image
        } else if let image = await loader.fetchImage(from: key.asUrl) {
            result = image
        } else {
            result = UIImage(systemName: "x.circle")!
        }
        
        return result
    }
    
    func fetchImage(from url: URL) async -> UIImage? {
        var result: UIImage? = nil
        
        if let image = await loader.fetchImage(from: url) {
            cache.setObject(image, forKey: url.asNSURL)
            result = image
        }
        
        return result
    }
    
    func removeImage(forKey key: Key) {
        cache.removeObject(forKey: key)
    }
    
    func clear() {
        cache.removeAllObjects()
    }
}

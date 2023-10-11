//
//  ImageCache.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 25/09/23.
//

import UIKit

protocol ImageCache: AnyObject {
    associatedtype Key: AnyObject
    
    func getImage(usingKey key: Key) async -> UIImage?
    func removeImage(forKey key: Key)
    func clear()
}

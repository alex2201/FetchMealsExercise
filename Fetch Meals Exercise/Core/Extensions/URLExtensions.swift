//
//  URLExtensions.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 25/09/23.
//

import Foundation

extension URL {
    var asNSURL: NSURL {
        NSURL(string: self.absoluteString)!
    }
}

extension NSURL {
    var asUrl: URL {
        URL(string: self.absoluteString!)!
    }
}

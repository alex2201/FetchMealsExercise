//
//  ArrayExtension.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 26/09/23.
//

import Foundation

extension Array where Element: Hashable {
    mutating func removingDuplicates() -> Self {
        let set = Set<Element>(self)
        return Array(set)
    }
}

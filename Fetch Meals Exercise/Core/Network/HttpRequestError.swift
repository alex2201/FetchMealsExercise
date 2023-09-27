//
//  HttpRequestError.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 26/09/23.
//

import Foundation

enum HttpRequestError: Error {
    case requestError(errorCode: Int)
    case decodingError
}

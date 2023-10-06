//
//  BaseScreenLogic.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 03/10/23.
//

import Combine

protocol BaseScreenLogicProtocol {
    var cancellables: Set<AnyCancellable> { get }
}

class BaseScreenLogic: BaseScreenLogicProtocol, ObservableObject {
    var cancellables = Set<AnyCancellable>()
}

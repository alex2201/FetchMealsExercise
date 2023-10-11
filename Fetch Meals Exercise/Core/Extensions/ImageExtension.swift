//
//  ImageExtension.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 06/10/23.
//

import SwiftUI

extension Image {
    func squared() -> some View {
        self
            .resizable()
            .aspectRatio(1.0, contentMode: .fit)
    }
}

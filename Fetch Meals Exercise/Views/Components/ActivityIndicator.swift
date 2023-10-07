//
//  ActivityIndicator.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 06/10/23.
//

import SwiftUI

struct ActivityIndicator: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .tint(Color.white)
                .scaleEffect(CGSize(width: 2.5, height: 2.5))
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.black.opacity(0.4))
    }
}

#Preview {
    ActivityIndicator()
}

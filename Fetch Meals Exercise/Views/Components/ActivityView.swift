//
//  ActivityView.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 11/10/23.
//

import SwiftUI

struct ActivityView<Content: View>: View {
    let showIndicator: Bool
    let content: (() -> Content)
    
    init(showIndicator: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.showIndicator = showIndicator
        self.content = content
    }
    
    var body: some View {
        ZStack {
            content()
            
            if showIndicator {
                ActivityIndicator()
            }
        }
    }
}

#Preview {
    ActivityView(showIndicator: false) {
        Text("Hello World!")
    }
}

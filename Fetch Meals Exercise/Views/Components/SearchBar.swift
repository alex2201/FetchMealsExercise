//
//  SearchBar.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 10/10/23.
//

import SwiftUI

struct SearchBar: View {
    internal init(text: Binding<String>, placeholder: String = "Search") {
        self._text = text
        self.placeholder = placeholder
    }
    
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8.0)
                    .strokeBorder(style: .init(lineWidth: 2))
            )
    }
}

#Preview {
    @State var text = ""
    
    return SearchBar(text: $text)
}

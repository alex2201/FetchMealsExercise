//
//  CategorySelectorItem.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 26/09/23.
//

import SwiftUI

struct CategorySelectorItem: View {
    let category: Category
    let isSelected: Bool
    
    var body: some View {
        Text(category.name)
            .foregroundStyle(isSelected ? Color.white : Color.black)
            .font(.footnote.bold())
            .padding([.top, .bottom], 6)
            .padding([.leading, .trailing], 12)
            .background(
                Capsule().fill(isSelected ? Color.black : Color.clear)
            )
            .background(
                Capsule().stroke(Color.black, lineWidth: isSelected ? 0 : 2)
            )
    }
}

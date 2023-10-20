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
    
    private var foregroundColor: Color {
        isSelected ? Color.white : Color.black
    }
    
    private var pillFillColor: Color {
        isSelected ? Color.black : Color.clear
    }
    private var pillStrokeWidth: CGFloat {
        isSelected ? 0 : 2
    }
    
    var body: some View {
        Text(category.name)
            .foregroundStyle(foregroundColor)
            .font(.footnote.bold())
            .padding([.top, .bottom], 6)
            .padding([.leading, .trailing], 12)
            .background(
                Capsule().fill(pillFillColor)
            )
            .background(
                Capsule().stroke(Color.black, lineWidth: pillStrokeWidth)
            )
    }
}

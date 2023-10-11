//
//  CategorySelectorView.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 25/09/23.
//

import SwiftUI

struct CategorySelectorView: View {
    let categoryList: [Category]
    @Binding var selectedCategory: Category?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())]) {
                ForEach(categoryList, id: \.id) { category in
                    let isSelected = (category == self.selectedCategory)
                    
                    Button {
                        if !isSelected {
                            self.selectedCategory = category
                        }
                    } label: {
                        CategorySelectorItem(category: category, isSelected: isSelected)
                    }
                }
            }
        }
        .frame(maxHeight: 40)
    }
}

#Preview {
    @State var selectedCategory: Category?
    
    return CategorySelectorView(categoryList: [], selectedCategory: $selectedCategory)
}

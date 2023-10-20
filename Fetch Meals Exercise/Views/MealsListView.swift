//
//  MealsListView.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 24/09/23.
//

import SwiftUI

struct MealsListView: View {
    let meals: [MealCompactItem]
    @Binding var selection: MealCompactItem?
    let numberOfColumns: Int
    
    private var columnLayout: [GridItem] {
        .init(repeating: GridItem(.flexible(), spacing: 16), count: numberOfColumns)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columnLayout, spacing: 16) {
                ForEach(meals) { meal in
                    Button(
                        action: { selection = meal },
                        label: {
                            MealListItemView(meal: meal)
                        }
                    )
                }
            }
            .padding([.leading, .trailing])
        }
    }
}

#Preview {
    @State var selection: MealCompactItem? = nil
    
    return MealsListView(meals: DessertListPreview.dessertList, selection: $selection, numberOfColumns: 2)
}

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
    
    private var columnLayout: [GridItem] {
        // TODO: Suport another layout for iPad
        [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)]
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
    
    return MealsListView(meals: DessertListPreview.dessertList, selection: $selection)
}

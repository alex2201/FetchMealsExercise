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
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
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

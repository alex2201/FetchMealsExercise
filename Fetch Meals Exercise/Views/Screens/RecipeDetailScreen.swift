//
//  RecipeDetailScreen.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 25/09/23.
//

import SwiftUI

struct RecipeDetailScreen: View {
    @State var expandIngredients = false
    @State var expandInstructions = false
    
    let meal: Meal
    
    init(meal: Meal) {
        self.meal = meal
    }
    
    var body: some View {
        DeviceRotationView { orientation in
            Group {
                if orientation.isLandscape {
                    RecipeDetailLandscapeLayout(meal: meal)
                } else {
                    RecipeDetailPortraitLayout(meal: meal)
                }
            }
            .scrollIndicators(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Details")
        }
    }
}

#Preview {
    NavigationStack {
        RecipeDetailScreen(meal: MealPreview.preview)
    }
}

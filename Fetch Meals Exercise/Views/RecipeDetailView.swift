//
//  RecipeDetailView.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 25/09/23.
//

import SwiftUI

struct RecipeDetailView: View {
    let meal: Meal
    
    var formattedInstructions: String {
        meal.instructions.replacingOccurrences(of: "\n", with: "\n\n")
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                LazyImage(url: meal.thumbnailUrl!) { image in
                    Image(uiImage: image)
                        .squared()
                } placeHolder: {
                    Image(systemName: "x.circle")
                        .squared()
                }
                
                Text(meal.name)
                    .font(.largeTitle.bold())
                    .fullWidth()
                
                Divider()
                
                VStack(alignment: .leading, spacing: 24) {
                    Text("Ingredients")
                        .font(.title)
                        .fullWidth()
                    
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(meal.ingredients) { ingredient in
                            Text("•    \(ingredient.name): **\(ingredient.measure)**")
                        }
                    }
                }
                .padding(16)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 24) {
                    Text("Instructions")
                        .font(.title)
                        .fullWidth()
                    Text(formattedInstructions)
                }
                .padding(16)
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Details")
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(meal: MealPreview.preview)
    }
}

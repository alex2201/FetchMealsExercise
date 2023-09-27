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
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                } placeHolder: {
                    Image(systemName: "x.circle")
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                }
                
                VStack(alignment: .leading, spacing: 24) {
                    Text("Ingredients")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(meal.ingredients) { ingredient in
                            Text("•    \(ingredient.name): **\(ingredient.measure)**")
                        }
                    }
                }
                .padding(16)
                
                VStack(alignment: .leading, spacing: 24) {
                    Text("Instructions")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                    Text(formattedInstructions)
                }
                .padding(16)
                
            }
        }
        .navigationTitle(meal.name)
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(meal: MealPreview.preview)
    }
}

//
//  RecipeDetailPortraitLayout.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 13/10/23.
//

import SwiftUI

struct RecipeDetailPortraitLayout: View {
    let meal: Meal
    
    @State private var expandIngredients = true
    @State private var expandInstructions = true
    
    init(meal: Meal) {
        self.meal = meal
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
                    HStack {
                        Text("Ingredients")
                            .font(.headline)
                        
                        Spacer()
                        
                        Button {
                            withAnimation(.smooth) {
                                expandIngredients.toggle()
                            }
                        } label: {
                            Image(systemName: "chevron.down")
                                .rotation3DEffect(
                                    expandIngredients ? .degrees(180) : .zero,
                                    axis: (x: 1.0, y: 0.0, z: 0.0)
                                )
                        }
                    }
                    
                    if expandIngredients {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(meal.ingredients) { ingredient in
                                Text("•    \(ingredient.name): **\(ingredient.measure)**")
                            }
                        }
                    }
                }
                .padding(16)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Text("Instructions")
                            .font(.headline)
                        
                        Spacer()
                        
                        Button {
                            withAnimation(.smooth) {
                                expandInstructions.toggle()
                            }
                        } label: {
                            Image(systemName: "chevron.down")
                                .rotation3DEffect(
                                    expandInstructions ? .degrees(180) : .zero,
                                    axis: (x: 1.0, y: 0.0, z: 0.0)
                                )
                        }
                    }
                    
                    if expandInstructions {
                        Text(meal.instructions)
                            .font(.body)
                    }
                }
                .padding(16)
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    RecipeDetailPortraitLayout(meal: MealPreview.preview)
}

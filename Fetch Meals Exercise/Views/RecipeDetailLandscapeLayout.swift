//
//  RecipeDetailLandscapeLayout.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 13/10/23.
//

import SwiftUI

struct RecipeDetailLandscapeLayout: View {
    let meal: Meal
    
    @State private var expandIngredients = true
    @State private var expandInstructions = true
    
    var body: some View {
        GeometryReader { geometery in
            HStack {
                VStack {
                    LazyImage(url: meal.thumbnailUrl!) { image in
                        Image(uiImage: image)
                            .squared()
                    } placeHolder: {
                        Image(systemName: "x.circle")
                            .squared()
                    }
                    Spacer()
                }
                .padding(.top, 24)
                .frame(width: geometery.size.width / 3)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        Text(meal.name)
                            .font(.largeTitle.bold())
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
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 8) {
                                ForEach(meal.ingredients) { ingredient in
                                    HStack {
                                        VStack {
                                            Text("•")
                                            Spacer()
                                        }
                                        
                                        Text("\(ingredient.name): **\(ingredient.measure)**")
                                    }
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
        .padding([.leading, .trailing])
    }
}

#Preview {
    NavigationStack {
        RecipeDetailLandscapeLayout(meal: MealPreview.preview)
    }
}

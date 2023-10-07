//
//  ContentView.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 22/09/23.
//

import SwiftUI

struct MainScreen: View {
    @ObservedObject var logic: MainScreenLogic
    
    init(logic _logic: MainScreenLogic = .init()) {
        self.logic = _logic
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                CategorySelectorView(categoryList: logic.categoryList, selectedCategory: $logic.selectedCategory)
                
                ZStack {
                    if !logic.mealList.isEmpty {
                        MealsListView(
                            meals: logic.mealList,
                            selection: $logic.selection
                        )
                    } else {
                        EmptyMealListView()
                    }
                    
                    if logic.showActivityIndicator {
                        ActivityIndicator()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(logic.navigationTitle)
            .navigationDestination(item: $logic.mealRecipe) { meal in
                RecipeDetailView(meal: meal)
            }
        }
        .task {
            await logic.initialLoad()
        }
    }
}

#Preview {
    MainScreen(logic: MainScreenLogic())
}

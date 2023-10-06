//
//  ContentView.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 22/09/23.
//

import SwiftUI

struct MainScreen: View {
    @ObservedObject var logic: MainScreenLogic
    
    init(logic _logic: MainScreenLogic) {
        self.logic = _logic
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                CategorySelectorView(categoryList: logic.categoryList, selectedCategory: $logic.selectedCategory)
                
                if !logic.showActivityIndicator {
                    if !logic.mealList.isEmpty {
                        MealsListView(
                            meals: logic.mealList,
                            selection: $logic.selection
                        )
                    } else {
                        EmptyMealListView()
                    }
                } else {
                    Spacer()
                    ProgressView()
                    Spacer()
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

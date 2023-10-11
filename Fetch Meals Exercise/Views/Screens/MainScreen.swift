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
                if logic.showSearchBar {
                    HStack {
                        SearchBar(text: $logic.seachBarText)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        
                        Button {
                            withAnimation {
                                logic.showSearchBar.toggle()
                            }
                        } label: {
                            Text("Cancel")
                        }
                    }
                    .padding([.leading, .trailing, .bottom])
                } else {
                    CategorySelectorView(categoryList: logic.categoryList, selectedCategory: $logic.selectedCategory)
                    .padding([.leading, .trailing, .bottom])
                }
                
                ActivityView(showIndicator: logic.showActivityIndicator) {
                    if !logic.mealListFiltered.isEmpty {
                        MealsListView(
                            meals: logic.mealListFiltered,
                            selection: $logic.selection
                        )
                    } else {
                        EmptyMealListView()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(logic.navigationTitle)
            .navigationDestination(item: $logic.mealRecipe) { meal in
                RecipeDetailView(meal: meal)
            }
            .toolbar {
                if !logic.showSearchBar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            withAnimation {
                                logic.showSearchBar.toggle()
                            }
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .tint(.black)
                        }
                    }
                }
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

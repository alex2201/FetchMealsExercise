//
//  ContentView.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 22/09/23.
//

import SwiftUI

struct MainScreen: View {
    @ObservedObject var vm: MainScreenVM
    
    init(vm: MainScreenVM) {
        self.vm = vm
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                CategorySelectorView(categoryList: vm.categoryList, selectedCategory: $vm.selectedCategory)
                
                if !vm.showActivityIndicator {
                    if !vm.mealList.isEmpty {
                        MealsListView(
                            meals: vm.mealList,
                            selection: $vm.selection
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
            .navigationTitle(vm.navigationTitle)
            .navigationDestination(item: $vm.mealRecipe) { meal in
                RecipeDetailView(meal: meal)
            }
        }
        .task {
            await vm.initialLoad()
        }
    }
}

#Preview {
    MainScreen(vm: MainScreenVM())
}

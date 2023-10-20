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
                    searchBarSection
                } else {
                    CategorySelectorView(
                        categoryList: logic.categoryList,
                        selectedCategory: $logic.selectedCategory
                    )
                    .padding([.leading, .trailing, .bottom])
                }
                
                ActivityView(showIndicator: logic.showActivityIndicator) {
                    if !logic.mealListFiltered.isEmpty {
                        DeviceRotationView { orientation in
                            MealsListView(
                                meals: logic.mealListFiltered,
                                selection: $logic.selection,
                                numberOfColumns: getNumberOfLayoutColumns(forOrientation: orientation)
                            )
                        }
                    } else {
                        EmptyMealListView()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(logic.navigationTitle)
            .navigationDestination(item: $logic.mealRecipe) { meal in
                RecipeDetailScreen(meal: meal)
            }
            .toolbar {
                if !logic.showSearchBar {
                    toolbarItem
                }
            }
        }
        .task {
            await logic.initialLoad()
        }
    }
    
    private var searchBarSection: some View {
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
    }
    
    private var toolbarItem: some ToolbarContent {
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
    
    private func getNumberOfLayoutColumns(forOrientation orientation: UIDeviceOrientation) -> Int {
        orientation.isLandscape ? 4 : 2
    }
}

#Preview {
    MainScreen()
}

//
//  MainScreenVM.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 26/09/23.
//

import Foundation
import Combine

class MainScreenVM: ObservableObject {
    @Published var categoryList: [Category] = []
    @Published var mealList: [MealCompactItem] = []
    @Published var selectedCategory: Category? = nil
    @Published var selection: MealCompactItem? = nil
    @Published var mealRecipe: Meal? = nil
    @Published var showActivityIndicator = false
    
    private var cancellables = Set<AnyCancellable>()
    private let mealService: TheMealDBService
    private let initialCategory: String = {
        AppConfig.shared.getConfig(withKey: "initialCategory") ?? ""
    }()
    
    var navigationTitle: String {
        selectedCategory?.name ?? "No selected category"
    }
    
    init(mealService: TheMealDBService = .shared) {
        self.mealService = mealService
        
        $selectedCategory
            .dropFirst()
            .compactMap({ $0 })
            .asyncMap({ [weak self] category in
                await self?.startTask {
                    await mealService.getMealList(forCategory: category)
                }
            })
            .compactMap({ $0 })
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] list in
                self?.mealList = list
            })
            .store(in: &cancellables)
        
        $selection
            .dropFirst()
            .compactMap({ $0 })
            .asyncMap({ [weak self] selectedMeal in
                await self?.startTask {
                    await mealService.getMealRecipe(for: selectedMeal)
                }
            })
            .compactMap({ $0 })
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] meal in
                self?.mealRecipe = meal
            })
            .store(in: &cancellables)
    }
    
    @MainActor
    func initialLoad() async {
        await startTask {
            categoryList = await mealService.getCategoryList()
                .sorted(by: { $0.name < $1.name })
            
            // Search for initial category, else take the first one
            if let initialCategory = self.categoryList.first(where: { $0.name == initialCategory }) {
                self.selectedCategory = initialCategory
            } else {
                self.selectedCategory = self.categoryList.first
            }
        }
    }
    
    @MainActor
    func startTask<T>(task: () async -> T) async -> T {
        showActivityIndicator = true
        let result = await task()
        showActivityIndicator = false
        
        return result
    }
}

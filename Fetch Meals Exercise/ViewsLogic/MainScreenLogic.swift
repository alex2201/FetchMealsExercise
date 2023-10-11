//
//  MainScreenLogic.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 26/09/23.
//

import Foundation
import Combine

class MainScreenLogic: BaseScreenLogic {
    @Published var categoryList: [Category] = []
    @Published var mealListFiltered: [MealCompactItem] = []
    @Published var selectedCategory: Category? = nil
    @Published var selection: MealCompactItem? = nil
    @Published var mealRecipe: Meal? = nil
    @Published var seachBarText: String = ""
    @Published var showActivityIndicator = false
    @Published var showSearchBar = false
    
    private let mealService: TheMealDBService
    private let initialCategory: String
    private var mealList: [MealCompactItem] = []
    
    var navigationTitle: String {
        selectedCategory?.name ?? "No selected category"
    }
    
    static private var defaultCategory: String {
        AppConfig.shared.getConfig(withKey: "initialCategory") ?? ""
    }
    
    init(mealService: TheMealDBService = TheMealDBService(), initialCategory: String = "") {
        self.initialCategory = initialCategory.isEmpty ? Self.defaultCategory : initialCategory
        self.mealService = mealService
        super.init()
        
        setupSuscribers()
    }
    
    private func setupSuscribers() {
        $selectedCategory
            .dropFirst()
            .compactMap({ $0 })
            .asyncMap({ [weak self] category in
                await self?.startTask { [weak self] in
                    await self?.mealService.getMealList(forCategory: category)
                }
            })
            .compactMap({ $0 })
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] list in
                self?.mealListFiltered = list
                self?.mealList = list
            })
            .store(in: &cancellables)
        
        $selection
            .dropFirst()
            .compactMap({ $0 })
            .asyncMap({ [weak self] selectedMeal in
                await self?.startTask { [weak self] in
                    await self?.mealService.getMealRecipe(for: selectedMeal)
                }
            })
            .compactMap({ $0 })
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] meal in
                self?.mealRecipe = meal
            })
            .store(in: &cancellables)
        
        $showSearchBar
            .dropFirst()
            .sink { [weak self] newValue in
                guard let self else { return }
                print("Show search bar", newValue)
                if !newValue {
                    seachBarText = ""
                    resetFilteredMealList()
                }
            }
            .store(in: &cancellables)
        
        $seachBarText
            .dropFirst()
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self, showSearchBar else { return }
                if text.isEmpty {
                    resetFilteredMealList()
                } else {
                    mealListFiltered = mealList.filter {
                        $0.name.lowercased().contains(text.lowercased())
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func resetFilteredMealList() {
        mealListFiltered = mealList
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
    private func startTask<T>(task: () async -> T) async -> T {
        showActivityIndicator = true
        let result = await task()
        showActivityIndicator = false
        
        return result
    }
}

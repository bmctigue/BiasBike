//
//  CategoryController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/14/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

protocol CategoryControllerProtocol {
    func loadSelectedCategories() -> [CategoryType]
    func saveSelectedCategories(categories: [CategoryType])
    func filteredCategoryTypes(categoryHash:[String:[Event]]) -> [CategoryType]
}

struct CategoryController: CategoryControllerProtocol {
    
    static let selectedCategoriesKey = "SelectedCategories"
    
    func loadSelectedCategories() -> [CategoryType] {
        if let categoryStrings = UserDefaults.standard.array(forKey: CategoryController.selectedCategoriesKey) as? [String] {
            let categories = categoryStrings.map{CategoryType(rawValue: $0)} as? [CategoryType]
            return categories!
        }
        return CategoryType.categories
    }
    
    func saveSelectedCategories(categories: [CategoryType]) {
        let categoryStrings: [String] = categories.map{$0.rawValue}
        UserDefaults.standard.set(categoryStrings, forKey: CategoryController.selectedCategoriesKey)
    }
    
    func filteredCategoryTypes(categoryHash:[String:[Event]]) -> [CategoryType] {
        let selectedCategories = loadSelectedCategories()
        return CategoryType.categories.filter{Array(categoryHash.keys).contains($0.rawValue) && selectedCategories.contains($0)}
    }
}

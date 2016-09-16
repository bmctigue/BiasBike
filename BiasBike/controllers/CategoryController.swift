//
//  CategoryController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/14/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

protocol CategoryControllerProtocol {
    func loadSelectedCategories() -> [Category]
    func saveSelectedCategories(categories: [Category])
    func filteredCategoryTypes(categoryHash:[String:[Event]]) -> [Category]
}

struct CategoryController: CategoryControllerProtocol {
    
    static let selectedCategoriesKey = "SelectedCategories"
    
    func loadSelectedCategories() -> [Category] {
        if let categoryStrings = UserDefaults.standard.array(forKey: CategoryController.selectedCategoriesKey) as? [String] {
            let categories = categoryStrings.map{Category(rawValue: $0)} as? [Category]
            return categories!
        }
        return Category.categories
    }
    
    func saveSelectedCategories(categories: [Category]) {
        let categoryStrings: [String] = categories.map{$0.rawValue}
        UserDefaults.standard.set(categoryStrings, forKey: CategoryController.selectedCategoriesKey)
    }
    
    func filteredCategoryTypes(categoryHash:[String:[Event]]) -> [Category] {
        let selectedCategories = loadSelectedCategories()
        return Category.categories.filter{Array(categoryHash.keys).contains($0.rawValue) && selectedCategories.contains($0)}
    }
}

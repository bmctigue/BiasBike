//
//  CategoryController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/14/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

class CategoryController: NSObject {
    
    static let sharedInstance = CategoryController.init()
    
    func categoryFromSortedCategories(section: Int, categoryHash:[String:[Event]]) -> CategoryType {
        let sortedCategories = CategoryType.categories.filter{Array(categoryHash.keys).contains($0.rawValue)}
        let category = sortedCategories[section]
        return category
    }
}

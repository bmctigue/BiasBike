//
//  CategoryController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/14/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

protocol CategoryControllerProtocol {
    func filteredCategoryTypes(categoryHash:[String:[Event]]) -> [CategoryType]
}

struct CategoryController: CategoryControllerProtocol {
    func filteredCategoryTypes(categoryHash:[String:[Event]]) -> [CategoryType] {
        return CategoryType.categories.filter{Array(categoryHash.keys).contains($0.rawValue)}
    }
}

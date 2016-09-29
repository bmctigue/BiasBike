//
//  CategoryControllerTests.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/14/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
@testable import BiasBike

class CategoryControllerTests: XCTestCase {
    
    func testSavingAndLoading() {
        let categories = Category.categories
        CategoryController().saveSelectedCategories(categories: categories)
        let result = CategoryController().loadSelectedCategories()
        XCTAssertEqual(result.count, Category.categories.count)
        
    }
    
    func testFilteredCategoryTypes() {
        EventController.sharedInstance.clear()
        EventController.sharedInstance.loadDefault()
        let hash = EventController.sharedInstance.categoryHash()
        let categories = CategoryController().filteredCategoryTypes(categoryHash: hash)
        XCTAssertEqual(categories, [.World,.Sports,.Politics])
    }
    
}

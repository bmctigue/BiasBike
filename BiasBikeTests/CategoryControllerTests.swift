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
    
    func testCategoryFromSortedCategories() {
        EventController.sharedInstance.clear()
        EventController.sharedInstance.loadDefault()
        let hash = EventController.sharedInstance.categoryHash()
        var type: CategoryType
        type = CategoryController.sharedInstance.categoryFromSortedCategories(section: 0, categoryHash: hash)
        XCTAssertEqual(type, .World)
        type = CategoryController.sharedInstance.categoryFromSortedCategories(section: 1, categoryHash: hash)
        XCTAssertEqual(type, .News)
        type = CategoryController.sharedInstance.categoryFromSortedCategories(section: 2, categoryHash: hash)
        XCTAssertEqual(type, .Politics)
    }
    
}

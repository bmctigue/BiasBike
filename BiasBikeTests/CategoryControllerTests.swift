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
    
    func testFilteredCategoryTypes() {
        EventController.sharedInstance.clear()
        EventController.sharedInstance.loadDefault()
        EventController.sharedInstance.save()
        let hash = EventController.sharedInstance.categoryHash()
        let categories = CategoryController().filteredCategoryTypes(categoryHash: hash)
        XCTAssertEqual(categories, [.World,.Sports,.Politics])
    }
    
}

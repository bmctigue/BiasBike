//
//  CategoryTests.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/17/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
@testable import BiasBike

class CategoryTests: XCTestCase {
    
    func testCategoryWorldColor() {
        let color = Category.World.color
        XCTAssertTrue(color.isEqual(UIColor.magenta))
    }
    
    func testCategorySportsColor() {
        let color = Category.Sports.color
        XCTAssertTrue(color.isEqual(UIColor.blue))
    }
    
    func testCategoryMythsColor() {
        let color = Category.Myths.color
        XCTAssertTrue(color.isEqual(UIColor.cyan))
    }
    
    func testCategoryReligionColor() {
        let color = Category.Religion.color
        XCTAssertTrue(color.isEqual(UIColor.red))
    }
    
    func testCategoryHealthColor() {
        let color = Category.Health.color
        XCTAssertTrue(color.isEqual(UIColor.green))
    }
    
    func testCategoryScienceColor() {
        let color = Category.Science.color
        XCTAssertTrue(color.isEqual(Theme.Yellow.color))
    }
    
    func testCategoryPoliticsColor() {
        let color = Category.Politics.color
        XCTAssertTrue(color.isEqual(UIColor.orange))
    }
    
}

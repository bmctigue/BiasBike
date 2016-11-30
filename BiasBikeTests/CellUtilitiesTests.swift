//
//  CellUtilitiesTests.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/21/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
@testable import BiasBike

class CellUtilitiesTests: XCTestCase {
    
    func testRatingImageNameString() {
        var name: String
        name = CellUtitilities().ratingImageNameString(rating: 20)
        XCTAssertEqual(name, "red_cell_blank")
        name = CellUtitilities().ratingImageNameString(rating: 40)
        XCTAssertEqual(name, "orange_cell_blank")
        name = CellUtitilities().ratingImageNameString(rating: 60)
        XCTAssertEqual(name, "yellow_cell_blank")
        name = CellUtitilities().ratingImageNameString(rating: 80)
        XCTAssertEqual(name, "green_cell_blank")
    }
}

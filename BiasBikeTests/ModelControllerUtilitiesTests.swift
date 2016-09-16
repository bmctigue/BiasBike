//
//  ModelControllerUtilitiesTests.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/15/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
@testable import BiasBike

class ModelControllerUtilitiesTests: XCTestCase {
    
    func testSaveAllModelControllers() {
        ModelControllerUtilities().saveAllModelControllers()
        XCTAssertTrue(true)
    }
    
}

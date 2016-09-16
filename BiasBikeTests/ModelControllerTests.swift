//
//  ModelControllerTests.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/10/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
@testable import BiasBike

class ModelControllerTests: XCTestCase {
    
    func testLoadDefault() {
        let modelController = ModelController<Event>.init(modelType:.Event)
        modelController.loadDefault()
        XCTAssertTrue(true)
    }
    
}

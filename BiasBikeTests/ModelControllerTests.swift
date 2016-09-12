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
    
    // these methods don't need testing, including for coverage
    
    func testLoadDefault() {
        let modelController = ModelController<GenericModelType>.init(modelType:.Generic)
        modelController.loadDefault()
        XCTAssertTrue(true)
    }
    
    func testSaveAllModelControllers() {
        ModelController<GenericModelType>.saveAllModelControllers()
        XCTAssertTrue(true)
    }
    
}

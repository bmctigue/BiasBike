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
    
    override func setUp() {
        ModelControllerUtilities().clearAllModelControllers()
    }
    
    func testRefreshAppData() {
        ModelControllerUtilities().refreshAppData()
        let events = EventController.sharedInstance.all(category: .World)
        XCTAssertEqual(events.count, 1)

        XCTAssertTrue(true)
    }
    
    func testClearAllModelControllers() {
        let events = EventController.sharedInstance.all(category: .World)
        XCTAssertEqual(events.count, 0)
    }
    
    func testLoadAllModelControllers() {
        ModelControllerUtilities().loadAllModelControllers()
        let events = EventController.sharedInstance.all(category: .World)
        XCTAssertEqual(events.count, 1)
        XCTAssertTrue(true)
    }
    
    func testSaveAllModelControllers() {
        ModelControllerUtilities().loadAllModelControllers()
        ModelControllerUtilities().clearAllModelControllers()
        EventController.sharedInstance.loadDefault()
        ModelControllerUtilities().saveAllModelControllers()
        let events = EventController.sharedInstance.all(category: .World)
        XCTAssertEqual(events.count, 1)
        XCTAssertTrue(true)
    }
    
}

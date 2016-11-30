//
//  FallacyControllerTests.swift
//  BiasBike
//
//  Created by Bruce McTigue on 10/1/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
@testable import BiasBike

class FallacyControllerTests: XCTestCase {
    
    var fallacies: [Fallacy] = []
    var fallacy: Fallacy?
    var fallacy2: Fallacy?
    let fallacyFactory: FallacyFactoryProtocol = FallacyFactory()
    
    override func setUp() {
        super.setUp()
        FallacyController.sharedInstance.clear()
        fallacy = fallacyFactory.create(title: "Fallacy One", summary: ".", example: "", url: "", icon: FallacyType.Authority.icon, type: FallacyType.Authority.rawValue)
        fallacy2 = fallacyFactory.create(title: "Fallacy Two", summary: "", example: "", url: "", icon: FallacyType.Anger.icon, type: FallacyType.Anger.rawValue)
    }
    
    func testClearFallacies() {
        FallacyController.sharedInstance.clear()
        fallacies = FallacyController.sharedInstance.all()
        XCTAssertTrue(fallacies.count == 0)
    }
    
    func testAllFallacyForType() {
        fallacies = FallacyController.sharedInstance.all(type: fallacy!.type)
        XCTAssertTrue(fallacies.count == 1)
    }
    
    func testLoadDefaultFallacies() {
        FallacyController.sharedInstance.clear()
        FallacyController.sharedInstance.loadDefault()
        fallacies = FallacyController.sharedInstance.all()
        XCTAssertTrue(fallacies.count == 10)
    }
    
    func testFindFallacy() {
        let foundFallacy = FallacyController.sharedInstance.find(key: (fallacy?.fallacyId)!)
        XCTAssertTrue(foundFallacy?.title == "Fallacy One")
    }
}

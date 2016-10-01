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
        fallacy = fallacyFactory.create(title: "Fallacy One", summary: ".", example: "", url: "", icon: FallacIcons.AnonymousAuthority.rawValue)
        fallacy2 = fallacyFactory.create(title: "Fallacy Two", summary: "", example: "", url: "", icon: FallacIcons.Authority.rawValue)
        FallacyController.sharedInstance.clear()
    }
    
    func fallacyInit() {
        let fallacy = fallacyFactory.create(title: "Fallacy One", summary: ".", example: "", url: "", icon: FallacIcons.AnonymousAuthority.rawValue)
        XCTAssertTrue(fallacy.title == "Fallacy One")
    }
    
    func testClearFallacies() {
        FallacyController.sharedInstance.update(item: fallacy!)
        FallacyController.sharedInstance.clear()
        fallacies = FallacyController.sharedInstance.all()
        XCTAssertTrue(fallacies.count == 0)
    }
    
    func testAddFallacy() {
        FallacyController.sharedInstance.update(item: fallacy!)
        fallacies = FallacyController.sharedInstance.all()
        XCTAssertTrue(fallacies.count == 1)
        FallacyController.sharedInstance.update(item: fallacy2!)
        fallacies = FallacyController.sharedInstance.all()
        XCTAssertTrue(fallacies.count == 2)
    }
    
    func testLoadDefaultFallacies() {
        FallacyController.sharedInstance.loadDefault()
        fallacies = FallacyController.sharedInstance.all()
        XCTAssertTrue(fallacies.count == 3)
    }
    
    func testFindFallacy() {
        FallacyController.sharedInstance.update(item: fallacy!)
        let foundFallacy = FallacyController.sharedInstance.find(key: (fallacy?.fallacyId)!)
        XCTAssertTrue(foundFallacy?.title == "Fallacy One")
    }
    
}

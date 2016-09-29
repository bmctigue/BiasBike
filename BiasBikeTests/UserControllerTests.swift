//
//  UserControllerTests.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/2/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
@testable import BiasBike

class UserControllerTests: XCTestCase {
    
    var users: [BiasUser] = []
    var testUser: BiasUser?
    var testUser2: BiasUser?
    let userFactory: UserFactoryProtocol = UserFactory()
    
    override func setUp() {
        super.setUp()
        testUser = userFactory.create(firstName: "Bruce", lastName: "Lee", url: "")
        testUser2 = userFactory.create(firstName: "Tom", lastName: "Slick", url: "")
        UserController.sharedInstance.clear()
    }
    
    func testUserInit() {
        let user = userFactory.create(firstName: "Bruce", lastName: "Lee", url: "")
        XCTAssertTrue(user.firstName == "Bruce")
    }
    
    func testClearUser() {
        UserController.sharedInstance.update(item: testUser!)
        UserController.sharedInstance.clear()
        users = UserController.sharedInstance.all()
        XCTAssertTrue(users.count == 0)
    }
    
    func testAddUser() {
        UserController.sharedInstance.update(item: testUser!)
        users = UserController.sharedInstance.all()
        XCTAssertTrue(users.count == 1)
        UserController.sharedInstance.update(item: testUser2!)
        users = UserController.sharedInstance.all()
        XCTAssertTrue(users.count == 2)
    }
    
    func testLoadDefaultUsers() {
        UserController.sharedInstance.loadDefault()
        let users = UserController.sharedInstance.all()
        XCTAssertTrue(users.count == 2)
    }
    
}

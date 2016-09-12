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
    
    var users: [User] = []
    var testUser: User?
    var testUser2: User?
    let userFactory: UserFactoryProtocol = UserFactory()
    
    override func setUp() {
        super.setUp()
        testUser = userFactory.create(firstName: "Bruce", lastName: "Lee", creationDate: Date(), url: "", rtRating: 45, aggRR: 50)
        testUser2 = userFactory.create(firstName: "Tom", lastName: "Slick", creationDate: Date(), url: "", rtRating: 90, aggRR: 65)
        UserController.sharedInstance.clear()
    }
    
    func testUserInit() {
        let user = userFactory.create(firstName: "Bruce", lastName: "Lee", creationDate: Date(), url: "", rtRating: 45, aggRR: 50)
        XCTAssertTrue(user.rtRating == 45)
    }
    
    func testClearUser() {
        UserController.sharedInstance.update(key: testUser!.userId, item: testUser!)
        UserController.sharedInstance.clear()
        users = UserController.sharedInstance.all()
        XCTAssertTrue(users.count == 0)
    }
    
    func testaddUser() {
        UserController.sharedInstance.update(key: testUser!.userId, item: testUser!)
        users = UserController.sharedInstance.all()
        XCTAssertTrue(users.count == 1)
        UserController.sharedInstance.update(key: testUser2!.userId, item: testUser2!)
        users = UserController.sharedInstance.all()
        XCTAssertTrue(users.count == 2)
    }
    
    func testLoadDefaultUsers() {
        UserController.sharedInstance.loadDefault()
        let users = UserController.sharedInstance.all()
        XCTAssertTrue(users.count == 2)
    }
    
}

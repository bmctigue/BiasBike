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
        testUser = userFactory.create(userId: "1", firstName: "Bruce", lastName: "Lee", creationDate: Date(), url: "", rtRating: 45, aggRR: 50)
        testUser2 = userFactory.create(userId: "2", firstName: "Tom", lastName: "Slick", creationDate: Date(), url: "", rtRating: 90, aggRR: 65)
        UserController.sharedInstance.clear()
        UserController.sharedInstance.save()
    }
    
    func testUserInit() {
        let user = userFactory.create(userId: "1", firstName: "Bruce", lastName: "Lee", creationDate: Date(), url: "", rtRating: 45, aggRR: 50)
        XCTAssertTrue(user.userId == "1")
    }
    
    func testClearUser() {
        UserController.sharedInstance.add(item: testUser!)
        UserController.sharedInstance.clear()
        UserController.sharedInstance.save()
        users = UserController.sharedInstance.items as! [User]
        XCTAssertTrue(users.count == 0)
    }
    
    func testaddUser() {
        UserController.sharedInstance.addUser(user: testUser!)
        UserController.sharedInstance.save()
        users = UserController.sharedInstance.users
        XCTAssertTrue(users.count == 1)
        UserController.sharedInstance.addUser(user: testUser2!)
        UserController.sharedInstance.save()
        users = UserController.sharedInstance.users
        XCTAssertTrue(users.count == 2)
    }
    
    func testLoadDefaultUsers() {
        UserController.sharedInstance.loadDefaultUsers()
        let users = UserController.sharedInstance.users
        XCTAssertTrue(users.count == 2)
    }
    
}

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
    
    override func setUp() {
        super.setUp()
        testUser = User(userId: "1", firstName: "Bruce", lastName: "Lee", creationDate: Date(), url: "", rtRating: 45, aggRR: 50)
        testUser2 = User(userId: "2", firstName: "Tom", lastName: "Slick", creationDate: Date(), url: "", rtRating: 90, aggRR: 65)
        UserController.sharedInstance.clearUsers()
        UserController.sharedInstance.save()
    }
    
    func testUserInit() {
        let user = User(userId: "1", firstName: "Bruce", lastName: "Lee", creationDate: Date(), url: "", rtRating: 45, aggRR: 50)
        XCTAssertTrue(user.userId == "1")
    }
    
    func testEmptyusers() {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: UserController.ArchiveURL.path)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        users = UserController.sharedInstance.users
        XCTAssertTrue(users.count == 0)
    }
    
    func testClearUser() {
        UserController.sharedInstance.addUser(user: testUser!)
        UserController.sharedInstance.save()
        UserController.sharedInstance.clearUsers()
        UserController.sharedInstance.save()
        users = UserController.sharedInstance.users
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

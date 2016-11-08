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
    var testRating: Rating?
    var testRating2: Rating?
    let userFactory: UserFactoryProtocol = UserFactory()
    let ratingFactory: RatingFactoryProtocol = RatingFactory()
    
    override func setUp() {
        super.setUp()
        testUser = userFactory.create(firstName: "Bruce", lastName: "Lee", url: "")
        testUser2 = userFactory.create(firstName: "Tom", lastName: "Slick", url: "")
        testRating = ratingFactory.create(rating: 10, modelId: "1", userId: (testUser?.userId)!)
        testRating2 = ratingFactory.create(rating: 90, modelId: "1", userId: (testUser2?.userId)!)
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
    
    func testFindUser() {
        UserController.sharedInstance.update(item: testUser!)
        let foundUser = UserController.sharedInstance.find(key: (testUser?.userId)!)
        XCTAssertEqual(foundUser?.firstName, "Bruce")
    }
    
    func testUserRatingsHash() {
        UserController.sharedInstance.update(item: testUser!)
        UserController.sharedInstance.update(item: testUser2!)
        RatingController.sharedInstance.update(item: testRating!)
        RatingController.sharedInstance.update(item: testRating2!)
        users = UserController.sharedInstance.all()
        let hash = UserController.sharedInstance.userRatingsHash()
        XCTAssertEqual(Array(hash.keys).count, 2)
    }
    
    func testUserAggRatingsHash() {
        UserController.sharedInstance.update(item: testUser!)
        UserController.sharedInstance.update(item: testUser2!)
        RatingController.sharedInstance.update(item: testRating!)
        RatingController.sharedInstance.update(item: testRating2!)
        RatingController.sharedInstance.update(item: testRating!)
        RatingController.sharedInstance.update(item: testRating2!)
        users = UserController.sharedInstance.all()
        let hash = UserController.sharedInstance.userAggRatingsHash()
        XCTAssertEqual(Array(hash.keys).count, 2)
    }
    
    func testLoadDefaultUsers() {
        UserController.sharedInstance.loadDefault()
        let users = UserController.sharedInstance.all()
        XCTAssertTrue(users.count == 2)
    }
    
}

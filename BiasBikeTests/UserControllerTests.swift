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
        UserController.sharedInstance.clear()
        RatingController.sharedInstance.clear()
        testUser = userFactory.create(firstName: "Bruce", lastName: "Lee", url: "")
        testUser2 = userFactory.create(firstName: "Tom", lastName: "Slick", url: "")
        testRating = ratingFactory.create(rating: 10, modelId: "1", userId: (testUser?.userId)!)
        testRating2 = ratingFactory.create(rating: 90, modelId: "1", userId: (testUser2?.userId)!)
    }
    
    func testClearUser() {
        UserController.sharedInstance.clear()
        users = UserController.sharedInstance.all()
        XCTAssertTrue(users.count == 0)
    }
    
    func testFindUser() {
        let foundUser = UserController.sharedInstance.find(key: (testUser?.userId)!)
        XCTAssertEqual(foundUser?.firstName, "Bruce")
    }
    
    func testUserRatingsHash() {
        users = UserController.sharedInstance.all()
        let hash = UserController.sharedInstance.userRatingsHash()
        XCTAssertEqual(Array(hash.keys).count, 2)
    }
    
    func testUserAggRatingsHash() {
        users = UserController.sharedInstance.all()
        let hash = UserController.sharedInstance.userAggRatingsHash()
        XCTAssertEqual(Array(hash.keys).count, 2)
    }
    
    func testLoadDefaultUsers() {
        UserController.sharedInstance.clear()
        UserController.sharedInstance.loadDefault()
        let users = UserController.sharedInstance.all()
        XCTAssertTrue(users.count == 2)
    }
}

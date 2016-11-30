//
//  ClaimControllerTests.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/31/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
@testable import BiasBike

class ClaimControllerTests: XCTestCase {
    
    var testUser: User?
    var testUser2: User?
    let userFactory: UserFactoryProtocol = UserFactory()
    var claims: [Claim] = []
    var testClaim: Claim?
    var testClaim2: Claim?
    let claimFactory: ClaimFactoryProtocol = ClaimFactory()
    var testRating: Rating?
    var testRating2: Rating?
    let ratingFactory: RatingFactoryProtocol = RatingFactory()
    let eventFactory: EventFactoryProtocol = EventFactory()
    var event1: Event?
    
    override func setUp() {
        super.setUp()
        ClaimController.sharedInstance.clear()
        RatingController.sharedInstance.clear()
        UserController.sharedInstance.clear()
        testUser = userFactory.create(firstName: "Bruce", lastName: "Lee", url: "")
        testUser2 = userFactory.create(firstName: "Tom", lastName: "Slick", url: "")
        event1 = eventFactory.create(title: "Event1", summary: "", url: "", photoUrl: "", category: Category.World.rawValue)
        testClaim = claimFactory.create(title: "The Plane Crashed", summary: "", url: "", event: event1!, userId: (testUser?.userId)!)
        testClaim2 = claimFactory.create(title: "High Jacked", summary: "", url: "", event: event1!, userId: (testUser2?.userId)!)
        testRating = ratingFactory.create(rating: 10, modelId: (testClaim?.claimId)!, userId: (testUser?.userId)!)
        testRating2 = ratingFactory.create(rating: 90, modelId: (testClaim?.claimId)!, userId: (testUser2?.userId)!)
    }
    
    func testClearClaims() {
        ClaimController.sharedInstance.clear()
        claims = ClaimController.sharedInstance.all()
        XCTAssertTrue(claims.count == 0)
    }
    
    func testFindClaim() {
        let foundClaim = ClaimController.sharedInstance.find(key: (testClaim?.claimId)!)
        XCTAssertTrue(foundClaim?.title == "The Plane Crashed")
    }
    
    func testClaimsRatingsHash() {
        var hash: [String:Int] = ClaimController.sharedInstance.claimsRatingsHash(event: event1!)
        var rating = hash[testClaim!.claimId]!
        XCTAssertEqual(rating, 90)
        hash = ClaimController.sharedInstance.claimsRatingsHash(userId: (testUser?.userId)!)
        rating = hash[testClaim!.claimId]!
        XCTAssertEqual(rating, 90)
    }
    
    func testClaimsAggRatingsHash() {
        var hash: [String:Int] = ClaimController.sharedInstance.claimsAggRatingsHash(event: event1!)
        var aggRating = hash[testClaim!.claimId]!
        XCTAssertEqual(aggRating, 50)
        hash = ClaimController.sharedInstance.claimsAggRatingsHash(userId: (testUser?.userId)!)
        aggRating = hash[testClaim!.claimId]!
        XCTAssertEqual(aggRating, 50)
    }
}

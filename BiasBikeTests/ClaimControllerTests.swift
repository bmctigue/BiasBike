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
    
    var testUser: BiasUser?
    var testUser2: BiasUser?
    let userFactory: UserFactoryProtocol = UserFactory()
    var claims: [Claim] = []
    var testClaim: Claim?
    var testClaim2: Claim?
    let claimFactory: ClaimFactoryProtocol = ClaimFactory()
    var testRating: Rating?
    var testRating2: Rating?
    let ratingFactory: RatingFactoryProtocol = RatingFactory()
    
    override func setUp() {
        super.setUp()
        UserController.sharedInstance.clear()
        testUser = userFactory.create(firstName: "Bruce", lastName: "Lee", url: "")
        testUser2 = userFactory.create(firstName: "Tom", lastName: "Slick", url: "")
        testClaim = claimFactory.create(title: "The Plane Crashed", summary: "", url: "", eventId: "1", userId: (testUser?.userId)!)
        testClaim2 = claimFactory.create(title: "High Jacked", summary: "", url: "", eventId: "1", userId: (testUser2?.userId)!)
        ClaimController.sharedInstance.clear()
        RatingController.sharedInstance.clear()
    }
    
    func testClaimsRatingsHash() {
        ClaimController.sharedInstance.update(item: testClaim!)
        ClaimController.sharedInstance.update(item: testClaim2!)
        UserController.sharedInstance.update(item: testUser!)
        UserController.sharedInstance.update(item: testUser2!)
        testRating = ratingFactory.create(rating: 10, modelId: (testClaim?.claimId)!, userId: (testUser?.userId)!)
        testRating2 = ratingFactory.create(rating: 90, modelId: (testClaim?.claimId)!, userId: (testUser2?.userId)!)
        RatingController.sharedInstance.update(item: testRating!)
        RatingController.sharedInstance.update(item: testRating2!)
        var hash: [String:Int] = ClaimController.sharedInstance.claimsRatingsHash(eventId: "1")
        var rating = hash[testClaim!.claimId]!
        XCTAssertEqual(rating, 90)
        hash = ClaimController.sharedInstance.claimsRatingsHash(userId: (testUser?.userId)!)
        rating = hash[testClaim!.claimId]!
        XCTAssertEqual(rating, 90)
    }
    
    func testClaimsAggRatingsHash() {
        ClaimController.sharedInstance.update(item: testClaim!)
        ClaimController.sharedInstance.update(item: testClaim2!)
        UserController.sharedInstance.update(item: testUser!)
        UserController.sharedInstance.update(item: testUser2!)
        testRating = ratingFactory.create(rating: 10, modelId: (testClaim?.claimId)!, userId: (testUser2?.userId)!)
        testRating2 = ratingFactory.create(rating: 90, modelId: (testClaim?.claimId)!, userId: (testUser2?.userId)!)
        RatingController.sharedInstance.update(item: testRating!)
        RatingController.sharedInstance.update(item: testRating2!)
        var hash: [String:Int] = ClaimController.sharedInstance.claimsAggRatingsHash(eventId: "1")
        var aggRating = hash[testClaim!.claimId]!
        XCTAssertEqual(aggRating, 50)
        hash = ClaimController.sharedInstance.claimsAggRatingsHash(userId: (testUser?.userId)!)
        aggRating = hash[testClaim!.claimId]!
        XCTAssertEqual(aggRating, 50)
    }
    
    func testClaimInit() {
        let claim = claimFactory.create(title: "The Plane Crashed", summary: "", url: "", eventId: "1", userId: "2")
        XCTAssertTrue(claim.title == "The Plane Crashed")
    }
    
    func testClearClaims() {
        ClaimController.sharedInstance.update(item: testClaim!)
        ClaimController.sharedInstance.clear()
        claims = ClaimController.sharedInstance.all()
        XCTAssertTrue(claims.count == 0)
    }
    
    func testAddClaim() {
        ClaimController.sharedInstance.update(item: testClaim!)
        claims = ClaimController.sharedInstance.all()
        XCTAssertTrue(claims.count == 1)
        ClaimController.sharedInstance.update(item: testClaim2!)
        claims = ClaimController.sharedInstance.all()
        XCTAssertTrue(claims.count == 2)
    }
    
}

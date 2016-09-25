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
    
    override func setUp() {
        super.setUp()
        UserController.sharedInstance.clear()
        testUser = userFactory.create(firstName: "Bruce", lastName: "Lee", creationDate: Date(), url: "")
        testUser2 = userFactory.create(firstName: "Tom", lastName: "Slick", creationDate: Date(), url: "")
        UserController.sharedInstance.update(key: testUser!.userId, item: testUser!)
        UserController.sharedInstance.update(key: testUser2!.userId, item: testUser2!)
        UserController.sharedInstance.save()
        testClaim = claimFactory.create(title: "The Plane Crashed", summary: "", creationDate: Date(), url: "", eventId: "1", userId: (testUser?.userId)!)
        testClaim2 = claimFactory.create(title: "High Jacked", summary: "", creationDate: Date(), url: "", eventId: "1", userId: (testUser2?.userId)!)
        ClaimController.sharedInstance.clear()
        ClaimController.sharedInstance.save()
        RatingController.sharedInstance.clear()
        RatingController.sharedInstance.save()
    }
    
    func testClaimsRatingsHash() {
        ClaimController.sharedInstance.update(key: testClaim!.claimId, item: testClaim!)
        ClaimController.sharedInstance.update(key: testClaim2!.claimId, item: testClaim2!)
        ClaimController.sharedInstance.save()
        testRating = ratingFactory.create(creationDate: Date(), rating: 10, modelId: testClaim!.claimId, userId: (testUser?.userId)!)
        testRating2 = ratingFactory.create(creationDate: Date(), rating: 90, modelId: testClaim!.claimId, userId: (testUser2?.userId)!)
        RatingController.sharedInstance.update(key: testRating!.ratingId, item: testRating!)
        RatingController.sharedInstance.update(key: testRating2!.ratingId, item: testRating2!)
        RatingController.sharedInstance.save()
        var hash: [String:Int] = ClaimController.sharedInstance.claimsRatingsHash(eventId: "1")
        var rating = hash[testClaim!.claimId]!
        XCTAssertEqual(rating, 90)
        hash = ClaimController.sharedInstance.claimsRatingsHash(userId: (testUser?.userId)!)
        rating = hash[testClaim!.claimId]!
        XCTAssertEqual(rating, 90)
    }
    
    func testClaimsAggRatingsHash() {
        ClaimController.sharedInstance.update(key: testClaim!.claimId, item: testClaim!)
        ClaimController.sharedInstance.update(key: testClaim2!.claimId, item: testClaim2!)
        ClaimController.sharedInstance.save()
        testRating = ratingFactory.create(creationDate: Date(), rating: 10, modelId: testClaim!.claimId, userId: (testUser2?.userId)!)
        testRating2 = ratingFactory.create(creationDate: Date(), rating: 90, modelId: testClaim!.claimId, userId: (testUser2?.userId)!)
        RatingController.sharedInstance.update(key: testRating!.ratingId, item: testRating!)
        RatingController.sharedInstance.update(key: testRating2!.ratingId, item: testRating2!)
        RatingController.sharedInstance.save()
        var hash: [String:Int] = ClaimController.sharedInstance.claimsAggRatingsHash(eventId: "1")
        var aggRating = hash[testClaim!.claimId]!
        XCTAssertEqual(aggRating, 50)
        hash = ClaimController.sharedInstance.claimsAggRatingsHash(userId: (testUser?.userId)!)
        aggRating = hash[testClaim!.claimId]!
        XCTAssertEqual(aggRating, 50)
    }
    
    func testClaimInit() {
        let claim = claimFactory.create(title: "The Plane Crashed", summary: "", creationDate: Date(), url: "", eventId: "1", userId: "2")
        XCTAssertTrue(claim.title == "The Plane Crashed")
    }
    
    func testClearClaims() {
        ClaimController.sharedInstance.update(key: testClaim!.claimId, item: testClaim!)
        ClaimController.sharedInstance.clear()
        ClaimController.sharedInstance.save()
        claims = ClaimController.sharedInstance.all()
        XCTAssertTrue(claims.count == 0)
    }
    
    func testAddClaim() {
        ClaimController.sharedInstance.update(key: testClaim!.claimId, item: testClaim!)
        ClaimController.sharedInstance.save()
        claims = ClaimController.sharedInstance.all()
        XCTAssertTrue(claims.count == 1)
        ClaimController.sharedInstance.update(key: testClaim2!.claimId, item: testClaim2!)
        ClaimController.sharedInstance.save()
        claims = ClaimController.sharedInstance.all()
        XCTAssertTrue(claims.count == 2)
    }
    
    func testLoadDefaultClaims() {
        ClaimController.sharedInstance.loadDefault()
        ClaimController.sharedInstance.save()
        let claims = ClaimController.sharedInstance.all()
        XCTAssertTrue(claims.count == 5)
    }

    
}

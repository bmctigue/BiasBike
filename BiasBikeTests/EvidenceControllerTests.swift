//
//  EvidenceControllerTests.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/1/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
@testable import BiasBike

class EvidenceControllerTests: XCTestCase {
    
    var testUser: User?
    var testUser2: User?
    let userFactory: UserFactoryProtocol = UserFactory()
    var items: [Evidence] = []
    var testClaim: Claim?
    var testEvidence: Evidence?
    var testEvidence2: Evidence?
    let evidenceFactory: EvidenceFactory = EvidenceFactory()
    var testRelevanceRating: RelevanceRating?
    var testRelevanceRating2: RelevanceRating?
    let relevanceRatingFactory: RelevanceRatingFactory = RelevanceRatingFactory()
    var testReliabilityRating: ReliabilityRating?
    var testReliabilityRating2: ReliabilityRating?
    let reliabilityRatingFactory: ReliabilityRatingFactory = ReliabilityRatingFactory()
    
    override func setUp() {
        super.setUp()
        UserController.sharedInstance.clear()
        testUser = userFactory.create(firstName: "Bruce", lastName: "Lee", creationDate: Date(), url: "")
        testUser2 = userFactory.create(firstName: "Tom", lastName: "Slick", creationDate: Date(), url: "")
        UserController.sharedInstance.update(key: testUser!.userId, item: testUser!)
        UserController.sharedInstance.update(key: testUser2!.userId, item: testUser2!)
        UserController.sharedInstance.save()
        testEvidence = evidenceFactory.create(title: "Wing Debris", summary: "", creationDate: Date(), url: "", claimId: "1", userId: (testUser?.userId)!)
        testEvidence2 = evidenceFactory.create(title: "Flight path", summary: "", creationDate: Date(), url: "", claimId: "1", userId: (testUser2?.userId)!)
        EvidenceController.sharedInstance.clear()
        EvidenceController.sharedInstance.save()
    }
    
    func testEvidenceClaimsHash() {
        testClaim = ClaimFactory().create(title: "The Plane Crashed", summary: "", creationDate: Date(), url: "", eventId: "1", userId: (testUser?.userId)!)
        ClaimController.sharedInstance.update(key: testClaim!.claimId, item: testClaim!)
        ClaimController.sharedInstance.save()
        testEvidence = evidenceFactory.create(title: "Wing Debris", summary: "", creationDate: Date(), url: "", claimId: (testClaim?.claimId)!, userId: (testUser?.userId)!)
        testEvidence2 = evidenceFactory.create(title: "Flight path", summary: "", creationDate: Date(), url: "", claimId: (testClaim?.claimId)!, userId: (testUser2?.userId)!)
        EvidenceController.sharedInstance.update(key: testEvidence!.evidenceId, item: testEvidence!)
        EvidenceController.sharedInstance.update(key: testEvidence2!.evidenceId, item: testEvidence2!)
        EvidenceController.sharedInstance.save()
        let hash = EvidenceController.sharedInstance.evidenceClaimsHash()
        XCTAssertEqual(Array(hash.keys).count, 1)
        let evidenceItems = hash[(testClaim?.claimId)!]
        XCTAssertEqual(evidenceItems?.count, 2)
    }
    
    func testRelevanceRatingsHash() {
        commonRelevanceRatings()
        let items = EvidenceController.sharedInstance.itemsForHash(claimId: "1")
        let hash: [String:Int] = EvidenceController.sharedInstance.evidenceRelevanceRatingsHash(items: items)
        let rating = hash[testEvidence!.evidenceId]!
        XCTAssertEqual(rating, 90)
    }
    
    func testRelevanceRatingsHashNil() {
        commonRelevanceRatings()
        let items = EvidenceController.sharedInstance.itemsForHash(claimId: nil)
        let hash: [String:Int] = EvidenceController.sharedInstance.evidenceRelevanceRatingsHash(items: items)
        XCTAssertEqual(Array(hash.keys).count, 2)
    }
    
    func testAggRelevanceRatingsHash() {
        commonRelevanceRatings()
        let items = EvidenceController.sharedInstance.itemsForHash(claimId: "1")
        let hash: [String:Int] = EvidenceController.sharedInstance.evidenceAggRelevanceRatingsHash(items: items)
        let rating = hash[testEvidence!.evidenceId]!
        XCTAssertEqual(rating, 50)
    }
    
    func testAggRelevanceRatingsHashNil() {
        commonRelevanceRatings()
        let items = EvidenceController.sharedInstance.itemsForHash(claimId: nil)
        let hash: [String:Int] = EvidenceController.sharedInstance.evidenceAggRelevanceRatingsHash(items: items)
        XCTAssertEqual(Array(hash.keys).count, 2)
    }
    
    func commonRelevanceRatings() {
        EvidenceController.sharedInstance.update(key: testEvidence!.evidenceId, item: testEvidence!)
        EvidenceController.sharedInstance.update(key: testEvidence2!.evidenceId, item: testEvidence2!)
        EvidenceController.sharedInstance.save()
        testRelevanceRating = relevanceRatingFactory.create(creationDate: Date(), rating: 10, modelId: testEvidence!.evidenceId, userId: "2") as? RelevanceRating
        testRelevanceRating2 = relevanceRatingFactory.create(creationDate: Date(), rating: 90, modelId: testEvidence!.evidenceId, userId: "2")  as? RelevanceRating
        RelevanceRatingController.sharedInstance.update(key: testRelevanceRating!.ratingId, item: testRelevanceRating!)
        RelevanceRatingController.sharedInstance.update(key: testRelevanceRating2!.ratingId, item: testRelevanceRating2!)
        RelevanceRatingController.sharedInstance.save()
    }
    
    func testReliabilityRatingsHash() {
        commonReliabilityRatings()
        let items = EvidenceController.sharedInstance.itemsForHash(claimId: "1")
        let hash: [String:Int] = EvidenceController.sharedInstance.evidenceReliabilityRatingsHash(items: items)
        let rating = hash[testEvidence!.evidenceId]!
        XCTAssertEqual(rating, 90)
    }
    
    func testReliabilityRatingsHashNil() {
        commonReliabilityRatings()
        let items = EvidenceController.sharedInstance.itemsForHash(claimId: nil)
        let hash: [String:Int] = EvidenceController.sharedInstance.evidenceReliabilityRatingsHash(items: items)
        XCTAssertEqual(Array(hash.keys).count, 2)
    }
    
    func testAggReliabilityRatingsHash() {
        commonReliabilityRatings()
        let items = EvidenceController.sharedInstance.itemsForHash(claimId: "1")
        let hash: [String:Int] = EvidenceController.sharedInstance.evidenceAggReliabilityRatingsHash(items: items)
        let rating = hash[testEvidence!.evidenceId]!
        XCTAssertEqual(rating, 50)
    }
    
    func testAggReliabilityRatingsHashNil() {
        commonReliabilityRatings()
        let items = EvidenceController.sharedInstance.itemsForHash(claimId: nil)
        let hash: [String:Int] = EvidenceController.sharedInstance.evidenceAggReliabilityRatingsHash(items: items)
        XCTAssertEqual(Array(hash.keys).count, 2)
    }
    
    func commonReliabilityRatings() {
        EvidenceController.sharedInstance.update(key: testEvidence!.evidenceId, item: testEvidence!)
        EvidenceController.sharedInstance.update(key: testEvidence2!.evidenceId, item: testEvidence2!)
        EvidenceController.sharedInstance.save()
        testReliabilityRating = reliabilityRatingFactory.create(creationDate: Date(), rating: 10, modelId: testEvidence!.evidenceId, userId: "2") as? ReliabilityRating
        testReliabilityRating2 = reliabilityRatingFactory.create(creationDate: Date(), rating: 90, modelId: testEvidence!.evidenceId, userId: "2")  as? ReliabilityRating
        ReliabilityRatingController.sharedInstance.update(key: testReliabilityRating!.ratingId, item: testReliabilityRating!)
        ReliabilityRatingController.sharedInstance.update(key: testReliabilityRating2!.ratingId, item: testReliabilityRating2!)
        ReliabilityRatingController.sharedInstance.save()
    }
    
    func testEvidenceInit() {
        let evidence = evidenceFactory.create(title: "Wing Debris", summary: "", creationDate: Date(), url: "", claimId: "1", userId: (testUser?.userId)!)
        XCTAssertTrue(evidence.title == "Wing Debris")
    }
    
    func testClearEvidence() {
        EvidenceController.sharedInstance.update(key: testEvidence!.evidenceId, item: testEvidence!)
        EvidenceController.sharedInstance.clear()
        EvidenceController.sharedInstance.save()
        items = EvidenceController.sharedInstance.all()
        XCTAssertTrue(items.count == 0)
    }
    
    func testAddEvidence() {
        EvidenceController.sharedInstance.update(key: testEvidence!.evidenceId, item: testEvidence!)
        EvidenceController.sharedInstance.save()
        items = EvidenceController.sharedInstance.all()
        XCTAssertTrue(items.count == 1)
        EvidenceController.sharedInstance.update(key: testEvidence2!.evidenceId, item: testEvidence2!)
        EvidenceController.sharedInstance.save()
        items = EvidenceController.sharedInstance.all()
        XCTAssertTrue(items.count == 2)
    }
    
    func testLoadDefaultEvidence() {
        EventController.sharedInstance.loadDefault()
        EventController.sharedInstance.save()
        ClaimController.sharedInstance.loadDefault()
        ClaimController.sharedInstance.save()
        EvidenceController.sharedInstance.loadDefault()
        EvidenceController.sharedInstance.save()
        let items = EvidenceController.sharedInstance.all()
        XCTAssertTrue(items.count == 4)
    }
    
}

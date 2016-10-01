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
    
    var testUser: BiasUser?
    var testUser2: BiasUser?
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
        testUser = userFactory.create(firstName: "Bruce", lastName: "Lee", url: "")
        testUser2 = userFactory.create(firstName: "Tom", lastName: "Slick", url: "")
        testEvidence = evidenceFactory.create(title: "Wing Debris", summary: "", url: "", claimId: "1", userId: (testUser?.userId)!)
        testEvidence2 = evidenceFactory.create(title: "Flight path", summary: "", url: "", claimId: "1", userId: (testUser2?.userId)!)
        EvidenceController.sharedInstance.clear()
    }
    
    func testEvidenceClaimsHash() {
        UserController.sharedInstance.update(item: testUser!)
        UserController.sharedInstance.update(item: testUser2!)
        testClaim = ClaimFactory().create(title: "The Plane Crashed", summary: "", url: "", eventId: "1", userId: (testUser?.userId)!)
        ClaimController.sharedInstance.update(item: testClaim!)
        testEvidence = evidenceFactory.create(title: "Wing Debris", summary: "", url: "", claimId: (testClaim?.claimId)!, userId: (testUser?.userId)!)
        testEvidence2 = evidenceFactory.create(title: "Flight path", summary: "", url: "", claimId: (testClaim?.claimId)!, userId: (testUser2?.userId)!)
        EvidenceController.sharedInstance.update(item: testEvidence!)
        EvidenceController.sharedInstance.update(item: testEvidence2!)
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
        EvidenceController.sharedInstance.update(item: testEvidence!)
        EvidenceController.sharedInstance.update(item: testEvidence2!)
        testRelevanceRating = relevanceRatingFactory.create(rating: 10, modelId: testEvidence!.evidenceId, userId: "2") as? RelevanceRating
        testRelevanceRating2 = relevanceRatingFactory.create(rating: 90, modelId: testEvidence!.evidenceId, userId: "2")  as? RelevanceRating
        RelevanceRatingController.sharedInstance.update(item: testRelevanceRating!)
        RelevanceRatingController.sharedInstance.update(item: testRelevanceRating2!)
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
        EvidenceController.sharedInstance.update(item: testEvidence!)
        EvidenceController.sharedInstance.update(item: testEvidence2!)
        testReliabilityRating = reliabilityRatingFactory.create(rating: 10, modelId: testEvidence!.evidenceId, userId: "2") as? ReliabilityRating
        testReliabilityRating2 = reliabilityRatingFactory.create(rating: 90, modelId: testEvidence!.evidenceId, userId: "2")  as? ReliabilityRating
        ReliabilityRatingController.sharedInstance.update(item: testReliabilityRating!)
        ReliabilityRatingController.sharedInstance.update(item: testReliabilityRating2!)
    }
    
    func testEvidenceInit() {
        let evidence = evidenceFactory.create(title: "Wing Debris", summary: "", url: "", claimId: "1", userId: (testUser?.userId)!)
        XCTAssertTrue(evidence.title == "Wing Debris")
    }
    
    func testClearEvidence() {
        EvidenceController.sharedInstance.update(item: testEvidence!)
        EvidenceController.sharedInstance.clear()
        items = EvidenceController.sharedInstance.all()
        XCTAssertTrue(items.count == 0)
    }
    
    func testAddEvidence() {
        EvidenceController.sharedInstance.update(item: testEvidence!)
        items = EvidenceController.sharedInstance.all()
        XCTAssertTrue(items.count == 1)
        EvidenceController.sharedInstance.update(item: testEvidence2!)
        items = EvidenceController.sharedInstance.all()
        XCTAssertTrue(items.count == 2)
    }
    
    func testFindEvidence() {
        EvidenceController.sharedInstance.update(item: testEvidence!)
        let foundEvidence = EvidenceController.sharedInstance.find(key: (testEvidence?.evidenceId)!)
        XCTAssertTrue(foundEvidence?.title == "Wing Debris")
    }
    
    func testFindEvidenceForUser() {
        EvidenceController.sharedInstance.update(item: testEvidence!)
        items = EvidenceController.sharedInstance.all(userId: (testUser?.userId)!)
        XCTAssertTrue(items.count == 1)
    }
    
}

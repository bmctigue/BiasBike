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
    let eventFactory: EventFactoryProtocol = EventFactory()
    var event1: Event?
    
    override func setUp() {
        super.setUp()
        EvidenceController.sharedInstance.clear()
        ClaimController.sharedInstance.clear()
        UserController.sharedInstance.clear()
        testUser = userFactory.create(firstName: "Bruce", lastName: "Lee", url: "")
        testUser2 = userFactory.create(firstName: "Tom", lastName: "Slick", url: "")
        event1 = eventFactory.create(title: "Event1", summary: "", url: "", photoUrl: "", category: Category.World.rawValue)
        testClaim = ClaimFactory().create(title: "The Plane Crashed", summary: "", url: "", event: event1!, userId: (testUser?.userId)!)
        testEvidence = evidenceFactory.create(title: "Wing Debris", summary: "", url: "", claim: testClaim!, userId: (testUser?.userId)!)
        testEvidence2 = evidenceFactory.create(title: "Flight path", summary: "", url: "", claim: testClaim!, userId: (testUser2?.userId)!)
    }
    
    func testClearEvidence() {
        EvidenceController.sharedInstance.clear()
        items = EvidenceController.sharedInstance.all()
        XCTAssertTrue(items.count == 0)
    }
    
    func testFindEvidence() {
        let foundEvidence = EvidenceController.sharedInstance.find(key: (testEvidence?.evidenceId)!)
        XCTAssertTrue(foundEvidence?.title == "Wing Debris")
    }
    
    func testFindEvidenceForUser() {
        items = EvidenceController.sharedInstance.all(userId: (testUser?.userId)!)
        XCTAssertTrue(items.count == 1)
    }
    
    func testEvidenceClaimsHash() {
        let hash = EvidenceController.sharedInstance.evidenceClaimsHash()
        XCTAssertEqual(Array(hash.keys).count, 1)
        let evidenceItems = hash[(testClaim?.claimId)!]
        XCTAssertEqual(evidenceItems?.count, 2)
    }
    
    func testRelevanceRatingsHash() {
        commonRelevanceRatings()
        let items = EvidenceController.sharedInstance.itemsForHash(claim: testClaim!)
        let hash: [String:Int] = EvidenceController.sharedInstance.evidenceRelevanceRatingsHash(items: items)
        let rating = hash[testEvidence!.evidenceId]!
        XCTAssertEqual(rating, 90)
    }
    
    func testRelevanceRatingsHashNil() {
        commonRelevanceRatings()
        let items = EvidenceController.sharedInstance.itemsForHash(claim: nil)
        let hash: [String:Int] = EvidenceController.sharedInstance.evidenceRelevanceRatingsHash(items: items)
        XCTAssertEqual(Array(hash.keys).count, 2)
    }
    
    func testAggRelevanceRatingsHash() {
        commonRelevanceRatings()
        let items = EvidenceController.sharedInstance.itemsForHash(claim: testClaim!)
        let hash: [String:Int] = EvidenceController.sharedInstance.evidenceAggRelevanceRatingsHash(items: items)
        let rating = hash[testEvidence!.evidenceId]!
        XCTAssertEqual(rating, 50)
    }
    
    func testAggRelevanceRatingsHashNil() {
        commonRelevanceRatings()
        let items = EvidenceController.sharedInstance.itemsForHash(claim: nil)
        let hash: [String:Int] = EvidenceController.sharedInstance.evidenceAggRelevanceRatingsHash(items: items)
        XCTAssertEqual(Array(hash.keys).count, 2)
    }
    
    func commonRelevanceRatings() {
        testRelevanceRating = relevanceRatingFactory.create(rating: 10, modelId: testEvidence!.evidenceId, userId: "2") as? RelevanceRating
        testRelevanceRating2 = relevanceRatingFactory.create(rating: 90, modelId: testEvidence!.evidenceId, userId: "2")  as? RelevanceRating
        RelevanceRatingController.sharedInstance.update(item: testRelevanceRating!)
        RelevanceRatingController.sharedInstance.update(item: testRelevanceRating2!)
    }
    
    func testReliabilityRatingsHash() {
        commonReliabilityRatings()
        let items = EvidenceController.sharedInstance.itemsForHash(claim: testClaim!)
        let hash: [String:Int] = EvidenceController.sharedInstance.evidenceReliabilityRatingsHash(items: items)
        let rating = hash[testEvidence!.evidenceId]!
        XCTAssertEqual(rating, 90)
    }
    
    func testReliabilityRatingsHashNil() {
        commonReliabilityRatings()
        let items = EvidenceController.sharedInstance.itemsForHash(claim: nil)
        let hash: [String:Int] = EvidenceController.sharedInstance.evidenceReliabilityRatingsHash(items: items)
        XCTAssertEqual(Array(hash.keys).count, 2)
    }
    
    func testAggReliabilityRatingsHash() {
        commonReliabilityRatings()
        let items = EvidenceController.sharedInstance.itemsForHash(claim: testClaim!)
        let hash: [String:Int] = EvidenceController.sharedInstance.evidenceAggReliabilityRatingsHash(items: items)
        let rating = hash[testEvidence!.evidenceId]!
        XCTAssertEqual(rating, 50)
    }
    
    func testAggReliabilityRatingsHashNil() {
        commonReliabilityRatings()
        let items = EvidenceController.sharedInstance.itemsForHash(claim: nil)
        let hash: [String:Int] = EvidenceController.sharedInstance.evidenceAggReliabilityRatingsHash(items: items)
        XCTAssertEqual(Array(hash.keys).count, 2)
    }
    
    func commonReliabilityRatings() {
        testReliabilityRating = reliabilityRatingFactory.create(rating: 10, modelId: testEvidence!.evidenceId, userId: "2") as? ReliabilityRating
        testReliabilityRating2 = reliabilityRatingFactory.create(rating: 90, modelId: testEvidence!.evidenceId, userId: "2")  as? ReliabilityRating
        ReliabilityRatingController.sharedInstance.update(item: testReliabilityRating!)
        ReliabilityRatingController.sharedInstance.update(item: testReliabilityRating2!)
    }
}

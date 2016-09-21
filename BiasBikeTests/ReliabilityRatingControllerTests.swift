//
//  ReliabilityRatingControllerTests.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/18/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
@testable import BiasBike

class ReliabilityRatingControllerTests: XCTestCase {
    
    var ratings: [ReliabilityRating] = []
    var testRating: ReliabilityRating?
    var testRating2: ReliabilityRating?
    let ratingFactory: ReliabilityRatingFactory = ReliabilityRatingFactory()
    
    override func setUp() {
        super.setUp()
        testRating = ratingFactory.create(creationDate: Date(), rating: 10, modelId: "1", userId: "2") as? ReliabilityRating
        testRating2 = ratingFactory.create(creationDate: Date(), rating: 90, modelId: "1", userId: "2") as? ReliabilityRating
        ReliabilityRatingController.sharedInstance.clear()
        ReliabilityRatingController.sharedInstance.save()
    }
    
    func testRatingInit() {
        let Rating = ratingFactory.create(creationDate: Date(), rating: 10, modelId: "1", userId: "2")
        XCTAssertTrue(Rating.rating == 10)
    }
    
    func testClearRatings() {
        ReliabilityRatingController.sharedInstance.update(key: testRating!.ratingId, item: testRating!)
        ReliabilityRatingController.sharedInstance.clear()
        ReliabilityRatingController.sharedInstance.save()
        ratings = ReliabilityRatingController.sharedInstance.all()
        XCTAssertTrue(ratings.count == 0)
    }
    
    func testAddRating() {
        ReliabilityRatingController.sharedInstance.update(key: testRating!.ratingId, item: testRating!)
        ReliabilityRatingController.sharedInstance.save()
        ratings = ReliabilityRatingController.sharedInstance.all()
        XCTAssertTrue(ratings.count == 1)
        ReliabilityRatingController.sharedInstance.update(key: testRating2!.ratingId, item: testRating2!)
        ReliabilityRatingController.sharedInstance.save()
        ratings = ReliabilityRatingController.sharedInstance.all()
        XCTAssertTrue(ratings.count == 2)
    }
    
    func testAverageRatingNoRatings() {
        let avg = ReliabilityRatingController.sharedInstance.averageRating(modelId: "1")
        XCTAssertEqual(avg, 0)
    }
    
    func testAverageRating() {
        ReliabilityRatingController.sharedInstance.update(key: testRating!.ratingId, item: testRating!)
        ReliabilityRatingController.sharedInstance.update(key: testRating2!.ratingId, item: testRating2!)
        ReliabilityRatingController.sharedInstance.save()
        let avg = ReliabilityRatingController.sharedInstance.averageRating(modelId: "1")
        XCTAssertEqual(avg, Int((testRating!.rating + testRating2!.rating)/2))
    }
    
    func testLatestRating() {
        ReliabilityRatingController.sharedInstance.update(key: testRating!.ratingId, item: testRating!)
        ReliabilityRatingController.sharedInstance.update(key: testRating2!.ratingId, item: testRating2!)
        ReliabilityRatingController.sharedInstance.save()
        let latestRating = ReliabilityRatingController.sharedInstance.latestRating(modelId: "1")
        XCTAssertEqual(latestRating, 90)
    }
}

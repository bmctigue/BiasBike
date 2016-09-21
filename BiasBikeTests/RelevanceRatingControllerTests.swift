//
//  RelevanceRatingControllerTests.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/18/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
@testable import BiasBike

class RelevanceRatingControllerTests: XCTestCase {
    
    var ratings: [RelevanceRating] = []
    var testRating: RelevanceRating?
    var testRating2: RelevanceRating?
    let ratingFactory: RelevanceRatingFactory = RelevanceRatingFactory()
    
    override func setUp() {
        super.setUp()
        testRating  = ratingFactory.create(creationDate: Date(), rating: 10, modelId: "1", userId: "2") as? RelevanceRating
        testRating2 = ratingFactory.create(creationDate: Date(), rating: 90, modelId: "1", userId: "2") as? RelevanceRating
        RelevanceRatingController.sharedInstance.clear()
        RelevanceRatingController.sharedInstance.save()
    }
    
    func testRatingInit() {
        let Rating = ratingFactory.create(creationDate: Date(), rating: 10, modelId: "1", userId: "2")
        XCTAssertTrue(Rating.rating == 10)
    }
    
    func testClearRatings() {
        RelevanceRatingController.sharedInstance.update(key: testRating!.ratingId, item: testRating!)
        RelevanceRatingController.sharedInstance.clear()
        RelevanceRatingController.sharedInstance.save()
        ratings = RelevanceRatingController.sharedInstance.all()
        XCTAssertTrue(ratings.count == 0)
    }
    
    func testAddRating() {
        RelevanceRatingController.sharedInstance.update(key: testRating!.ratingId, item: testRating!)
        RelevanceRatingController.sharedInstance.save()
        ratings = RelevanceRatingController.sharedInstance.all()
        XCTAssertTrue(ratings.count == 1)
        RelevanceRatingController.sharedInstance.update(key: testRating2!.ratingId, item: testRating2!)
        RelevanceRatingController.sharedInstance.save()
        ratings = RelevanceRatingController.sharedInstance.all()
        XCTAssertTrue(ratings.count == 2)
    }
    
    func testAverageRatingNoRatings() {
        let avg = RelevanceRatingController.sharedInstance.averageRating(modelId: "1")
        XCTAssertEqual(avg, 0)
    }
    
    func testAverageRating() {
        RelevanceRatingController.sharedInstance.update(key: testRating!.ratingId, item: testRating!)
        RelevanceRatingController.sharedInstance.update(key: testRating2!.ratingId, item: testRating2!)
        RelevanceRatingController.sharedInstance.save()
        let avg = RelevanceRatingController.sharedInstance.averageRating(modelId: "1")
        XCTAssertEqual(avg, Int((testRating!.rating + testRating2!.rating)/2))
    }
    
    func testLatestRating() {
        RelevanceRatingController.sharedInstance.update(key: testRating!.ratingId, item: testRating!)
        RelevanceRatingController.sharedInstance.update(key: testRating2!.ratingId, item: testRating2!)
        RelevanceRatingController.sharedInstance.save()
        let latestRating = RelevanceRatingController.sharedInstance.latestRating(modelId: "1")
        XCTAssertEqual(latestRating, 90)
    }
}

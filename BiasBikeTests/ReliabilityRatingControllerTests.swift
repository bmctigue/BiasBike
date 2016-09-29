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
        testRating = ratingFactory.create(rating: 10, modelId: "1", userId: "2") as? ReliabilityRating
        testRating2 = ratingFactory.create(rating: 90, modelId: "1", userId: "2") as? ReliabilityRating
        ReliabilityRatingController.sharedInstance.clear()
    }
    
    func testRatingInit() {
        let Rating = ratingFactory.create(rating: 10, modelId: "1", userId: "2")
        XCTAssertTrue(Rating.rating == 10)
    }
    
    func testClearRatings() {
        ReliabilityRatingController.sharedInstance.update(item: testRating!)
        ReliabilityRatingController.sharedInstance.clear()
        ratings = ReliabilityRatingController.sharedInstance.all()
        XCTAssertTrue(ratings.count == 0)
    }
    
    func testAddRating() {
        ReliabilityRatingController.sharedInstance.update(item: testRating!)
        ratings = ReliabilityRatingController.sharedInstance.all()
        XCTAssertTrue(ratings.count == 1)
        ReliabilityRatingController.sharedInstance.update(item: testRating2!)
        ratings = ReliabilityRatingController.sharedInstance.all()
        XCTAssertTrue(ratings.count == 2)
    }
}

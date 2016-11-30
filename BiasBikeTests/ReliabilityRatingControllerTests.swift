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
        ReliabilityRatingController.sharedInstance.clear()
        testRating = ratingFactory.create(rating: 10, modelId: "1", userId: "2") as? ReliabilityRating
        testRating2 = ratingFactory.create(rating: 90, modelId: "1", userId: "2") as? ReliabilityRating
    }
    
    func testClearRatings() {
        ReliabilityRatingController.sharedInstance.clear()
        ratings = ReliabilityRatingController.sharedInstance.all()
        XCTAssertTrue(ratings.count == 0)
    }
    
    func testFindRating() {
        let foundRating = ReliabilityRatingController.sharedInstance.find(key: (testRating?.ratingId)!)
        XCTAssertEqual(foundRating?.rating, 10)
    }
    
    func testFindRatingForUser() {
        ratings = ReliabilityRatingController.sharedInstance.all(userId: "2")
        XCTAssertTrue(ratings.count == 2)
    }
}

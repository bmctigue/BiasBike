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
        RelevanceRatingController.sharedInstance.clear()
        testRating  = ratingFactory.create(rating: 10, modelId: "1", userId: "2") as? RelevanceRating
        testRating2 = ratingFactory.create(rating: 90, modelId: "1", userId: "2") as? RelevanceRating
    }
    
    func testClearRatings() {
        RelevanceRatingController.sharedInstance.clear()
        ratings = RelevanceRatingController.sharedInstance.all()
        XCTAssertTrue(ratings.count == 0)
    }
    
    func testFindRating() {
        let foundRating = RelevanceRatingController.sharedInstance.find(key: (testRating?.ratingId)!)
        XCTAssertEqual(foundRating?.rating, 10)
    }
    
    func testFindRatingForUser() {
        ratings = RelevanceRatingController.sharedInstance.all(userId: "2")
        XCTAssertTrue(ratings.count == 2)
    }
}

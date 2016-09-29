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
        testRating  = ratingFactory.create(rating: 10, modelId: "1", userId: "2") as? RelevanceRating
        testRating2 = ratingFactory.create(rating: 90, modelId: "1", userId: "2") as? RelevanceRating
        RelevanceRatingController.sharedInstance.clear()
    }
    
    func testRatingInit() {
        let Rating = ratingFactory.create(rating: 10, modelId: "1", userId: "2")
        XCTAssertTrue(Rating.rating == 10)
    }
    
    func testClearRatings() {
        RelevanceRatingController.sharedInstance.update(item: testRating!)
        RelevanceRatingController.sharedInstance.clear()
        ratings = RelevanceRatingController.sharedInstance.all()
        XCTAssertTrue(ratings.count == 0)
    }
    
    func testAddRating() {
        RelevanceRatingController.sharedInstance.update(item: testRating!)
        ratings = RelevanceRatingController.sharedInstance.all()
        XCTAssertTrue(ratings.count == 1)
        RelevanceRatingController.sharedInstance.update(item: testRating2!)
        ratings = RelevanceRatingController.sharedInstance.all()
        XCTAssertTrue(ratings.count == 2)
    }
}

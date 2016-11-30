//
//  RatingControllerTests.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/18/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
@testable import BiasBike

class RatingControllerTests: XCTestCase {
    
    var ratings: [Rating] = []
    var testRating: Rating?
    var testRating2: Rating?
    let ratingFactory: RatingFactoryProtocol = RatingFactory()
    
    override func setUp() {
        super.setUp()
        RatingController.sharedInstance.clear()
        testRating = ratingFactory.create(rating: 10, modelId: "1", userId: "2")
        testRating2 = ratingFactory.create(rating: 90, modelId: "1", userId: "2")
    }
    
    func testClearRatings() {
        RatingController.sharedInstance.clear()
        ratings = RatingController.sharedInstance.all()
        XCTAssertTrue(ratings.count == 0)
    }
    
    func testFindRating() {
        let foundRating = RatingController.sharedInstance.find(key: (testRating?.ratingId)!)
        XCTAssertEqual(foundRating?.rating, 10)
    }
    
    func testFindRatingForUser() {
        ratings = RatingController.sharedInstance.all(userId: "2")
        XCTAssertTrue(ratings.count == 2)
    }
    
    func testAverageRatingAllRatings() {
        let ratings = RatingController.sharedInstance.all(modelId: "1")
        let avg = RatingController.sharedInstance.averageRating(ratings: ratings)
        XCTAssertEqual(avg, 50)
    }
    
    func testAverageRating() {
        let ratings = RatingController.sharedInstance.all(modelId: "1")
        let avg = RatingController.sharedInstance.averageRating(ratings: ratings)
        XCTAssertEqual(avg, Int((testRating!.rating + testRating2!.rating)/2))
    }
    
    func testLatestRating() {
        let ratings = RatingController.sharedInstance.all(modelId: "1")
        let latestRating = RatingController.sharedInstance.latestRating(ratings: ratings)
        XCTAssertEqual(latestRating, 90)
    }
}

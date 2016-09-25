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
        testRating = ratingFactory.create(creationDate: Date(), rating: 10, modelId: "1", userId: "2")
        testRating2 = ratingFactory.create(creationDate: Date(), rating: 90, modelId: "1", userId: "2")
        RatingController.sharedInstance.clear()
        RatingController.sharedInstance.save()
    }
    
    func testRatingInit() {
        let Rating = ratingFactory.create(creationDate: Date(), rating: 10, modelId: "1", userId: "2")
        XCTAssertTrue(Rating.rating == 10)
    }
    
    func testClearRatings() {
        RatingController.sharedInstance.update(key: testRating!.ratingId, item: testRating!)
        RatingController.sharedInstance.clear()
        RatingController.sharedInstance.save()
        ratings = RatingController.sharedInstance.all()
        XCTAssertTrue(ratings.count == 0)
    }
    
    func testAddRating() {
        RatingController.sharedInstance.update(key: testRating!.ratingId, item: testRating!)
        RatingController.sharedInstance.save()
        ratings = RatingController.sharedInstance.all()
        XCTAssertTrue(ratings.count == 1)
        RatingController.sharedInstance.update(key: testRating2!.ratingId, item: testRating2!)
        RatingController.sharedInstance.save()
        ratings = RatingController.sharedInstance.all()
        XCTAssertTrue(ratings.count == 2)
    }
    
    func testAverageRatingNoRatings() {
        let ratings = RatingController.sharedInstance.all(modelId: "1")
        let avg = RatingController.sharedInstance.averageRating(ratings: ratings)
        XCTAssertEqual(avg, 0)
    }
    
    func testAverageRating() {
        RatingController.sharedInstance.update(key: testRating!.ratingId, item: testRating!)
        RatingController.sharedInstance.update(key: testRating2!.ratingId, item: testRating2!)
        RatingController.sharedInstance.save()
        let ratings = RatingController.sharedInstance.all(modelId: "1")
        let avg = RatingController.sharedInstance.averageRating(ratings: ratings)
        XCTAssertEqual(avg, Int((testRating!.rating + testRating2!.rating)/2))
    }
    
    func testLatestRating() {
        RatingController.sharedInstance.update(key: testRating!.ratingId, item: testRating!)
        RatingController.sharedInstance.update(key: testRating2!.ratingId, item: testRating2!)
        RatingController.sharedInstance.save()
        let ratings = RatingController.sharedInstance.all(modelId: "1")
        let latestRating = RatingController.sharedInstance.latestRating(ratings: ratings)
        XCTAssertEqual(latestRating, 90)
    }
}

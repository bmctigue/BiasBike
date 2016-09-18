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
    
    func testDefaultProgressViewSettings() {
        let circularProgress: KDCircularProgress = KDCircularProgress()
        RatingController().defaultProgressViewSettings(circularProgress: circularProgress)
        XCTAssertTrue(circularProgress.roundedCorners)
    }
    
    func testProgressColor() {
        var color: UIColor
        color = RatingController().progressColor(value: 80)
        XCTAssertTrue(color.isEqual(UIColor.red))
        color = RatingController().progressColor(value: 100)
        XCTAssertTrue(color.isEqual(UIColor.orange))
        color = RatingController().progressColor(value: 200)
        XCTAssertTrue(color.isEqual(Theme.Yellow.color))
        color = RatingController().progressColor(value: 300)
        XCTAssertTrue(color.isEqual(UIColor.green))
    }
    
    func testSliderValueConversion() {
        var result: Double
        result = RatingController().sliderValueConversion(rating: 0)
        XCTAssertEqual(result, 0)
        result = RatingController().sliderValueConversion(rating: 100)
        XCTAssertEqual(result, RatingController.sliderMax)
    }
    
}

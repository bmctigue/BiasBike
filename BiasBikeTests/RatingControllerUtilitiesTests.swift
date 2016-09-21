//
//  RatingControllerUtilitiesTests.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/20/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
@testable import BiasBike

class RatingControllerUtilitiesTests: XCTestCase {
    
    func testDefaultProgressViewSettings() {
        let circularProgress: KDCircularProgress = KDCircularProgress()
        RatingControllerUtilities().defaultProgressViewSettings(circularProgress: circularProgress)
        XCTAssertTrue(circularProgress.roundedCorners)
    }
    
    func testProgressColor() {
        var color: UIColor
        color = RatingControllerUtilities().progressColor(value: 80)
        XCTAssertTrue(color.isEqual(Theme.Red.color))
        color = RatingControllerUtilities().progressColor(value: 100)
        XCTAssertTrue(color.isEqual(Theme.Orange.color))
        color = RatingControllerUtilities().progressColor(value: 200)
        XCTAssertTrue(color.isEqual(Theme.Yellow.color))
        color = RatingControllerUtilities().progressColor(value: 300)
        XCTAssertTrue(color.isEqual(Theme.Green.color))
    }
    
    func testSliderValueConversion() {
        var result: Double
        result = RatingControllerUtilities().sliderValueConversion(rating: 0)
        XCTAssertEqual(result, 0)
        result = RatingControllerUtilities().sliderValueConversion(rating: 100)
        XCTAssertEqual(result, RatingControllerUtilities.sliderMax)
    }
    
}

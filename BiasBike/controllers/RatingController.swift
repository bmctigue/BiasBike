//
//  RatingController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/18/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import UIKit

struct RatingController {
    
    static var sliderMax: Double = 360
    
    func defaultProgressViewSettings(circularProgress: KDCircularProgress) {
        circularProgress.startAngle = -90
        circularProgress.progressThickness = 0.2
        circularProgress.trackThickness = 0.6
        circularProgress.clockwise = true
        circularProgress.gradientRotateSpeed = 2
        circularProgress.roundedCorners = true
        circularProgress.glowMode = .noGlow
        circularProgress.glowAmount = 0.9
        circularProgress.setColors(colors: UIColor.red)
    }
    
    func progressColor(value: Double) -> UIColor {
        var color: UIColor
        if value <= 90 {
            color = UIColor.red
        } else if value <= 180 {
            color = UIColor.orange
        } else if value <= 270 {
            color = Theme.Yellow.color
        } else {
            color = UIColor.green
        }
        return color
    }
    
    func sliderValueConversion(rating: Int) -> Double {
        let value = Double(rating) / 100.0
        return value * RatingController.sliderMax
    }
}

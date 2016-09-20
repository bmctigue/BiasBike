//
//  RatingController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/18/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import UIKit

class RatingController: ModelController<Rating> {
    
    static let sharedInstance = RatingController.init(modelType: ModelType.Rating)
    static var sliderMax: Double = 360
    
    func all(modelId: String) -> [Rating] {
        let items = all()
        return items.filter{$0.modelId == modelId}
    }
    
    func averageRating(modelId: String) -> Int {
        let items = all(modelId:modelId)
        if items.count == 0 {
            return 0
        }
        let ratingTotal = items.reduce(0) {sum, rating in sum + rating.rating}
        return Int(ratingTotal/items.count)
    }
    
    func latestRating(modelId: String) -> Int {
        var items: [Rating] = all(modelId:modelId)
        if items.count == 0 {
            return 50
        }
        items = items.sorted(by: {
            $0.creationDate < $1.creationDate
        })
        return items.last!.rating
    }
    
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

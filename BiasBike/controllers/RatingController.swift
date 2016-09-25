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
    
    func all(modelId: String) -> [Rating] {
        let items = all()
        return items.filter{$0.modelId == modelId}
    }
    
    func latestRating(ratings: [Rating]) -> Int {
        var ratings = ratings
        if ratings.count == 0 {
            return 50
        }
        ratings = ratings.sorted(by: {
            $0.creationDate < $1.creationDate
        })
        return ratings.last!.rating
    }
    
    func averageRating(ratings: [Rating]) -> Int {
        if ratings.count == 0 {
            return 0
        }
        let ratingTotal = ratings.reduce(0) {sum, rating in sum + rating.rating}
        return Int(ratingTotal/ratings.count)
    }
    
}

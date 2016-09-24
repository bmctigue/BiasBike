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
    
    func averageRating(modelId: String) -> Int {
        let items = all(modelId:modelId)
        if items.count == 0 {
            return 0
        }
        let ratingTotal = items.reduce(0) {sum, rating in sum + rating.rating}
        return Int(ratingTotal/items.count)
    }
    
}

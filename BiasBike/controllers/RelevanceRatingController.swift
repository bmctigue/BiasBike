//
//  RelevanceRatingController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/20/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import UIKit

final class RelevanceRatingController: ModelController<RelevanceRating> {
    
    static let sharedInstance = RelevanceRatingController.init(modelType: ModelType.RelevanceRating)
    
    func all(modelId: String) -> [RelevanceRating] {
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
        var items: [RelevanceRating] = all(modelId:modelId)
        if items.count == 0 {
            return 50
        }
        items = items.sorted(by: {
            $0.creationDate < $1.creationDate
        })
        return items.last!.rating
    }
}

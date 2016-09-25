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
    
    func all(userId: String) -> [RelevanceRating] {
        let items = all()
        return items.filter{$0.userId == userId}
    }
    
}

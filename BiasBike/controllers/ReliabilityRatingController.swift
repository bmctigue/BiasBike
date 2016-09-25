//
//  ReliabilityRatingController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/20/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import UIKit

final class ReliabilityRatingController: ModelController<ReliabilityRating> {
    
    static let sharedInstance = ReliabilityRatingController.init(modelType: ModelType.ReliabilityRating)
    
    func all(modelId: String) -> [ReliabilityRating] {
        let items = all()
        return items.filter{$0.modelId == modelId}
    }
    
    func all(userId: String) -> [ReliabilityRating] {
        let items = all()
        return items.filter{$0.userId == userId}
    }
    
}



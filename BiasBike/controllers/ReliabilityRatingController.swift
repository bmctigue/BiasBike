//
//  ReliabilityRatingController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/20/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

final class ReliabilityRatingController: ModelController {
    
    static let sharedInstance = ReliabilityRatingController.init()
    
    func all() -> [ReliabilityRating] {
        let items = realm.objects(ReliabilityRating.self)
        if items.count == 0 {
            return [ReliabilityRating]()
        }
        return Array(items)
    }
    
    func find(key: String) -> ReliabilityRating? {
        return realm.object(ofType: ReliabilityRating.self, forPrimaryKey: key)
    }
    
    func update(item: ReliabilityRating) {
        try! self.realm.write {
            self.realm.add(item, update: true)
        }
    }
    
    func save(item: ReliabilityRating) {
        update(item: item)
    }
    
    func all(modelId: String) -> [ReliabilityRating] {
        let items = all()
        return items.filter{$0.modelId == modelId}
    }
    
    func all(userId: String) -> [ReliabilityRating] {
        let items = all()
        return items.filter{$0.userId == userId}
    }
    
}



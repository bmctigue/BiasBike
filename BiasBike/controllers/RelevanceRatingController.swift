//
//  RelevanceRatingController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/20/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

final class RelevanceRatingController: ModelController {
    
    static let sharedInstance = RelevanceRatingController.init()
    
    func all() -> [RelevanceRating] {
        let items = realm.objects(RelevanceRating.self)
        if items.count == 0 {
            return [RelevanceRating]()
        }
        return Array(items)
    }
    
    func find(key: String) -> RelevanceRating? {
        return realm.object(ofType: RelevanceRating.self, forPrimaryKey: key)
    }
    
    func update(item: RelevanceRating) {
        try! self.realm.write {
            self.realm.add(item, update: true)
        }
    }
    
    func all(modelId: String) -> [RelevanceRating] {
        let items = all()
        return items.filter{$0.modelId == modelId}
    }
    
    func all(userId: String) -> [RelevanceRating] {
        let items = all()
        return items.filter{$0.userId == userId}
    }
    
}

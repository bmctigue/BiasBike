//
//  RatingController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/18/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class RatingController: ModelController {
    
    static let sharedInstance = RatingController.init()
    
    func all() -> [Rating] {
        let items = realm.objects(Rating.self)
        if items.count == 0 {
            return [Rating]()
        }
        return Array(items)
    }
    
    func find(key: String) -> Rating? {
        return realm.object(ofType: Rating.self, forPrimaryKey: key)
    }
    
    func update(item: Rating) {
        try! self.realm.write {
            self.realm.add(item, update: true)
        }
    }
    
    func all(modelId: String) -> [Rating] {
        let items = all()
        return items.filter{$0.modelId == modelId}
    }
    
    func all(userId: String) -> [Rating] {
        let items = all()
        return items.filter{$0.userId == userId}
    }
    
    func latestRating(ratings: [Rating]) -> Int {
        var ratings = ratings
        if ratings.count == 0 {
            return 0
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

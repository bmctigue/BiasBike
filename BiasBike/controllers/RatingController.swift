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
    
    func aggRatingsPerEventHash(eventRatingsHash: [String:[Rating]]) -> [String:Int] {
        var eventRatingsHash = eventRatingsHash
        var aggRatingsPerEventHash: [String:Int] = [:]
        var ratings: [Rating]? = []
        for eventId in eventRatingsHash.keys {
            ratings = eventRatingsHash[eventId]
            aggRatingsPerEventHash[eventId] = averageRating(ratings: ratings!)
        }
        return aggRatingsPerEventHash
    }
    
    func eventRatingsHash() -> [String:[Rating]] {
        var eventRatingsHash: [String:[Rating]] = [:]
        var ratings: [Rating]? = []
        let claims = ClaimController.sharedInstance.all()
        for claim in claims {
            ratings = eventRatingsHash[(claim.event?.eventId)!]
            if ratings == nil {
                ratings = []
            }
            ratings!.append(contentsOf: all(modelId: claim.claimId))
            eventRatingsHash[(claim.event?.eventId)!] = ratings
        }
        return eventRatingsHash
    }
}

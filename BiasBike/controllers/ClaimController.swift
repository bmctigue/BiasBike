//
//  ClaimController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/31/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift

final class ClaimController: ModelController {
    
    static let sharedInstance = ClaimController.init()
    
    func all() -> [Claim] {
        let items = realm.objects(Claim.self)
        if items.count == 0 {
            return [Claim]()
        }
        return Array(items)
    }
    
    func find(key: String) -> Claim? {
        return realm.object(ofType: Claim.self, forPrimaryKey: key)
    }
    
    func all(event: Event) -> [Claim] {
        return Array(event.claims)
    }
    
    func all(userId: String) -> [Claim] {
        let items = all()
        return items.filter{$0.userId == userId}
    }
    
    func claimsRatingsHash(event: Event) -> [String:Int] {
        let items = all(event:event)
        return claimsRatingsHashLatestCommon(items: items)
    }
    func claimsRatingsHash(userId: String) -> [String:Int] {
        let items = all(userId:userId)
        return claimsRatingsHashLatestCommon(items: items)
    }
    
    func claimsAggRatingsHash(event: Event) -> [String:Int] {
        let items = all(event:event)
        return claimsRatingsHashAverageCommon(items: items)
    }
    
    func claimsAggRatingsHash(userId: String) -> [String:Int] {
        let items = all(userId:userId)
        return claimsRatingsHashAverageCommon(items: items)
    }
    
    func claimsRatingsHashLatestCommon(items: [Claim]) -> [String:Int] {
        var hash: [String:Int] = [:]
        for claim: Claim in items {
            let ratings = RatingController.sharedInstance.all(modelId: claim.claimId)
            hash[claim.claimId] = RatingController.sharedInstance.latestRating(ratings: ratings)
        }
        return hash
    }
    
    func claimsRatingsHashAverageCommon(items: [Claim]) -> [String:Int] {
        var hash: [String:Int] = [:]
        for claim: Claim in items {
            let ratings = RatingController.sharedInstance.all(modelId: claim.claimId)
            hash[claim.claimId] = RatingController.sharedInstance.averageRating(ratings: ratings)
        }
        return hash
    }
    
    func loadDefault() {
        let users = UserController.sharedInstance.all()
        var user = users.first!
        var events = EventController.sharedInstance.all(category: .World)
        var event: Event? = events.first
        let claimFactory = ClaimFactory()
        if let event = event {
            _ = claimFactory.create(title: "The Plane Crashed", summary: "Your probablity: 60%", url: "", event: event, userId: user.userId)
            _ = claimFactory.create(title: "High Jacked", summary: "Your probablity: 45%", url: "", event: event, userId: user.userId)
            _ = claimFactory.create(title: "The Plane was Stolen", summary: "Your probablity: 70%", url: "", event: event, userId: user.userId)
        }
        events = EventController.sharedInstance.all(category: .Sports)
        event = events.first
        user = users.last!
        if let event = event {
            _ = claimFactory.create(title: "Fabricated His Story", summary: "Your probablity: 60%", url: "", event: event, userId: user.userId)
            _ = claimFactory.create(title: "Robbed by Guards", summary: "Your probablity: 70%", url: "", event: event, userId: user.userId)
        }
    }
}

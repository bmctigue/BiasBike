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
        let realm = try! Realm()
        let items = realm.objects(Claim.self)
        if items.count == 0 {
            return [Claim]()
        }
        return Array(items)
    }
    
    func find(key: String) -> Claim? {
        return realm.object(ofType: Claim.self, forPrimaryKey: key)
    }
    
    func update(item: Claim) {
        DispatchQueue.global().async {
            try! self.realm.write {
                self.realm.add(item, update: true)
            }
        }
    }
    
    func all(eventId: String) -> [Claim] {
        let items = all()
        return items.filter{$0.eventId == eventId}
    }
    
    func all(userId: String) -> [Claim] {
        let items = all()
        return items.filter{$0.userId == userId}
    }
    
    func claimsRatingsHash(eventId: String) -> [String:Int] {
        let items = all(eventId:eventId)
        return claimsRatingsHashLatestCommon(items: items)
    }
    func claimsRatingsHash(userId: String) -> [String:Int] {
        let items = all(userId:userId)
        return claimsRatingsHashLatestCommon(items: items)
    }
    
    func claimsAggRatingsHash(eventId: String) -> [String:Int] {
        let items = all(eventId:eventId)
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
            let claim1 = claimFactory.create(title: "The Plane Crashed", summary: "Your probablity: 60%", url: "", eventId: event.eventId, userId: user.userId)
            update(item: claim1)
            let claim2 = claimFactory.create(title: "High Jacked", summary: "Your probablity: 45%", url: "", eventId: event.eventId, userId: user.userId)
            update(item: claim2)
            let claim3 = claimFactory.create(title: "The Plane was Stolen", summary: "Your probablity: 70%", url: "", eventId: event.eventId, userId: user.userId)
            update(item: claim3)
        }
        events = EventController.sharedInstance.all(category: .Sports)
        event = events.first
        user = users.last!
        if let event = event {
            let claim4 = claimFactory.create(title: "Fabricated His Story", summary: "Your probablity: 60%", url: "", eventId: event.eventId, userId: user.userId)
            update(item: claim4)
            let claim5 = claimFactory.create(title: "Robbed by Guards", summary: "Your probablity: 70%", url: "", eventId: event.eventId, userId: user.userId)
            update(item: claim5)
        }
    }
}

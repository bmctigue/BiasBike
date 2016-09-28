//
//  EvidenceController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/1/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift

final class EvidenceController: ModelController {
    
    static let sharedInstance = EvidenceController.init()
    
    func all() -> [Evidence] {
        let realm = try! Realm()
        let items = realm.objects(Evidence.self)
        if items.count == 0 {
            return [Evidence]()
        }
        return Array(items)
    }
    
    func find(key: String) -> Evidence? {
        return realm.object(ofType: Evidence.self, forPrimaryKey: key)
    }
    
    func update(item: Evidence) {
        DispatchQueue.global().async {
            try! self.realm.write {
                self.realm.add(item, update: true)
            }
        }
    }
    
    func all(claimId: String) -> [Evidence] {
        let items = all()
        return items.filter{$0.claimId == claimId}
    }
    
    func all(userId: String) -> [Evidence] {
        let items = all()
        return items.filter{$0.userId == userId}
    }
    
    func evidenceClaimsHash() -> [String:[Evidence]] {
        var hash: [String:[Evidence]] = [:]
        let claims = ClaimController.sharedInstance.all()
        for claim: Claim in claims {
            let evidence = all(claimId: claim.claimId)
            if evidence.count > 0 {
                hash[claim.claimId] = all(claimId: claim.claimId)
            }
        }
        return hash
    }
    
    func evidenceRelevanceRatingsHash(items: [Evidence]) -> [String:Int] {
        var hash: [String:Int] = [:]
        for evidenceItem: Evidence in items {
            let ratings = RelevanceRatingController.sharedInstance.all(modelId: evidenceItem.evidenceId)
            hash[evidenceItem.evidenceId] = RatingController.sharedInstance.latestRating(ratings: ratings)
        }
        return hash
    }
    
    func evidenceAggRelevanceRatingsHash(items: [Evidence]) -> [String:Int] {
        var hash: [String:Int] = [:]
        for evidenceItem: Evidence in items {
            let ratings = RelevanceRatingController.sharedInstance.all(modelId: evidenceItem.evidenceId)
            hash[evidenceItem.evidenceId] = RatingController.sharedInstance.averageRating(ratings: ratings)
        }
        return hash
    }
    
    func evidenceReliabilityRatingsHash(items: [Evidence]) -> [String:Int] {
        var hash: [String:Int] = [:]
        for evidenceItem: Evidence in items {
            let ratings = ReliabilityRatingController.sharedInstance.all(modelId: evidenceItem.evidenceId)
            hash[evidenceItem.evidenceId] = RatingController.sharedInstance.latestRating(ratings: ratings)
        }
        return hash
    }
    
    func evidenceAggReliabilityRatingsHash(items: [Evidence]) -> [String:Int] {
        var hash: [String:Int] = [:]
        for evidenceItem: Evidence in items {
            let ratings = ReliabilityRatingController.sharedInstance.all(modelId: evidenceItem.evidenceId)
            hash[evidenceItem.evidenceId] = RatingController.sharedInstance.averageRating(ratings: ratings)
        }
        return hash
    }
    
    func itemsForHash(claimId: String?) -> [Evidence] {
        let items: [Evidence]
        if let claimId = claimId {
            items = all(claimId:claimId)
        } else {
            items = all()
        }
        return items
    }
    
    func loadDefault() {
        // World
        let users = UserController.sharedInstance.all()
        var user = users.first!
        var events = EventController.sharedInstance.all(category: .World)
        var event: Event? = events.first
        var claims = ClaimController.sharedInstance.all(eventId: (event?.eventId)!)
        var claim: Claim? = claims.first
        let evidenceFactory = EvidenceFactory()
        let evidence1 = evidenceFactory.create(title: "Wing Debris", summary: "", url: "debris", claimId: (claim?.claimId)!, userId: user.userId)
        update(item: evidence1)
        let evidence2 = evidenceFactory.create(title: "Flight Path", summary: "", url: "flightpath", claimId: (claim?.claimId)!, userId: user.userId)
        update(item: evidence2)
        // Sports
        user = users.last!
        events = EventController.sharedInstance.all(category: .Sports)
        event = events.first
        claims = ClaimController.sharedInstance.all(eventId: (event?.eventId)!)
        claim = claims.first
        let evidence3 = evidenceFactory.create(title: "Broke Bathroom Door", summary: "", url: "lochte-footage", claimId: (claim?.claimId)!, userId: user.userId)
        update(item: evidence3)
        let evidence4 = evidenceFactory.create(title: "No Panic", summary: "", url: "lochte-station", claimId: (claim?.claimId)!, userId: user.userId)
        update(item: evidence4)
    }
}

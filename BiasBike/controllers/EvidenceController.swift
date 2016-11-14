//
//  EvidenceController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/1/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

final class EvidenceController: ModelController {
    
    static let sharedInstance = EvidenceController.init()
    
    func all() -> [Evidence] {
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
        try! self.realm.write {
            self.realm.add(item, update: true)
        }
    }
    
    func all(claim: Claim) -> [Evidence] {
        return Array(claim.evidence)
    }
    
    func all(userId: String) -> [Evidence] {
        let items = all()
        return items.filter{$0.userId == userId}
    }
    
    func updateFallacies(item: Evidence, fallacies: [Fallacy]) {
        try! self.realm.write {
            item.fallacies.removeAll()
            item.fallacies.append(objectsIn: fallacies)
        }
    }
    
    func evidenceClaimsHash() -> [String:[Evidence]] {
        var hash: [String:[Evidence]] = [:]
        let claims = ClaimController.sharedInstance.all()
        for claim: Claim in claims {
            let evidence = all(claim: claim)
            if evidence.count > 0 {
                hash[claim.claimId] = all(claim: claim)
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
    
    func itemsForHash(claim: Claim?) -> [Evidence] {
        let items: [Evidence]
        if let claim = claim {
            items = all(claim:claim)
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
        var claims: [Claim] = []
        if let event = event {
            claims = ClaimController.sharedInstance.all(event: event)
        }
        var claim: Claim? = claims.first
        let evidenceFactory = EvidenceFactory()
        let evidence1 = evidenceFactory.create(title: "Wing Debris", summary: "", url: "debris", claim: claim!, userId: user.userId)
        update(item: evidence1)
        let evidence2 = evidenceFactory.create(title: "Flight Path", summary: "", url: "flightpath", claim: claim!, userId: user.userId)
        update(item: evidence2)
        // Sports
        user = users.last!
        events = EventController.sharedInstance.all(category: .Sports)
        event = events.first
        claims = ClaimController.sharedInstance.all(event: event!)
        claim = claims.first
        let evidence3 = evidenceFactory.create(title: "Broke Bathroom Door", summary: "", url: "lochte-footage", claim: claim!, userId: user.userId)
        update(item: evidence3)
        let evidence4 = evidenceFactory.create(title: "No Panic", summary: "", url: "lochte-station", claim: claim!, userId: user.userId)
        update(item: evidence4)
    }
}

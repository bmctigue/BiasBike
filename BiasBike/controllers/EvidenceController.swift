//
//  EvidenceController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/1/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

final class EvidenceController: ModelController<Evidence> {
    
    static let sharedInstance = EvidenceController.init(modelType: ModelType.Evidence)
    
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
            hash[evidenceItem.evidenceId] = RelevanceRatingController.sharedInstance.latestRating(modelId: evidenceItem.evidenceId)
        }
        return hash
    }
    
    func evidenceAggRelevanceRatingsHash(items: [Evidence]) -> [String:Int] {
        var hash: [String:Int] = [:]
        for evidenceItem: Evidence in items {
            hash[evidenceItem.evidenceId] = RelevanceRatingController.sharedInstance.averageRating(modelId: evidenceItem.evidenceId)
        }
        return hash
    }
    
    func evidenceReliabilityRatingsHash(items: [Evidence]) -> [String:Int] {
        var hash: [String:Int] = [:]
        for evidenceItem: Evidence in items {
            hash[evidenceItem.evidenceId] = ReliabilityRatingController.sharedInstance.latestRating(modelId: evidenceItem.evidenceId)
        }
        return hash
    }
    
    func evidenceAggReliabilityRatingsHash(items: [Evidence]) -> [String:Int] {
        var hash: [String:Int] = [:]
        for evidenceItem: Evidence in items {
            hash[evidenceItem.evidenceId] = ReliabilityRatingController.sharedInstance.averageRating(modelId: evidenceItem.evidenceId)
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
    
    override func loadDefault() {
        // World
        let users = UserController.sharedInstance.all()
        var user = users.first!
        var events = EventController.sharedInstance.all(category: .World)
        var event: Event? = events.first
        var claims = ClaimController.sharedInstance.all(eventId: (event?.eventId)!)
        var claim: Claim? = claims.first
        let evidenceFactory = EvidenceFactory()
        let evidence1 = evidenceFactory.create(title: "Wing Debris", summary: "", creationDate: Date(), url: "debris", claimId: (claim?.claimId)!, userId: user.userId)
        update(key: evidence1.evidenceId, item: evidence1)
        let evidence2 = evidenceFactory.create(title: "Flight Path", summary: "", creationDate: Date(), url: "flightpath", claimId: (claim?.claimId)!, userId: user.userId)
        update(key: evidence2.evidenceId, item: evidence2)
        // Sports
        user = users.last!
        events = EventController.sharedInstance.all(category: .Sports)
        event = events.first
        claims = ClaimController.sharedInstance.all(eventId: (event?.eventId)!)
        claim = claims.first
        let evidence3 = evidenceFactory.create(title: "Broke Bathroom Door", summary: "", creationDate: Date(), url: "lochte-footage", claimId: (claim?.claimId)!, userId: user.userId)
        update(key: evidence3.evidenceId, item: evidence3)
        let evidence4 = evidenceFactory.create(title: "No Panic", summary: "", creationDate: Date(), url: "lochte-station", claimId: (claim?.claimId)!, userId: user.userId)
        update(key: evidence4.evidenceId, item: evidence4)
    }
}

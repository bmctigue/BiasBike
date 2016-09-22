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
    
    func evidenceRelevanceRatingsHash(claimId: String?) -> [String:Int] {
        let items = itemsForHash(claimId: claimId)
        var hash: [String:Int] = [:]
        for evidenceItem: Evidence in items {
            hash[evidenceItem.evidenceId] = RelevanceRatingController.sharedInstance.latestRating(modelId: evidenceItem.evidenceId)
        }
        return hash
    }
    
    func evidenceAggRelevanceRatingsHash(claimId: String?) -> [String:Int] {
        let items = itemsForHash(claimId: claimId)
        var hash: [String:Int] = [:]
        for evidenceItem: Evidence in items {
            hash[evidenceItem.evidenceId] = RelevanceRatingController.sharedInstance.averageRating(modelId: evidenceItem.evidenceId)
        }
        return hash
    }
    
    func evidenceReliabilityRatingsHash(claimId: String?) -> [String:Int] {
        let items = itemsForHash(claimId: claimId)
        var hash: [String:Int] = [:]
        for evidenceItem: Evidence in items {
            hash[evidenceItem.evidenceId] = ReliabilityRatingController.sharedInstance.latestRating(modelId: evidenceItem.evidenceId)
        }
        return hash
    }
    
    func evidenceAggReliabilityRatingsHash(claimId: String?) -> [String:Int] {
        let items = itemsForHash(claimId: claimId)
        var hash: [String:Int] = [:]
        for evidenceItem: Evidence in items {
            hash[evidenceItem.evidenceId] = ReliabilityRatingController.sharedInstance.averageRating(modelId: evidenceItem.evidenceId)
        }
        return hash
    }
    
    private func itemsForHash(claimId: String?) -> [Evidence] {
        let items: [Evidence]
        if let claimId = claimId {
            items = all(claimId:claimId)
        } else {
            items = all()
        }
        return items
    }
    
    override func loadDefault() {
        let events = EventController.sharedInstance.all(category: .World)
        let event: Event? = events.first
        let claims = ClaimController.sharedInstance.all(eventId: (event?.eventId)!)
        let claim: Claim? = claims.first
        let evidenceFactory = EvidenceFactory()
        let evidence1 = evidenceFactory.create(title: "Wing Debris", summary: "", creationDate: Date(), url: "debris", claimId: (claim?.claimId)!)
        update(key: evidence1.evidenceId, item: evidence1)
        let evidence2 = evidenceFactory.create(title: "Flight path", summary: "", creationDate: Date(), url: "flightpath", claimId: (claim?.claimId)!)
        update(key: evidence2.evidenceId, item: evidence2)
    }
}

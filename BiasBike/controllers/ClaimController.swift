//
//  ClaimController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/31/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

final class ClaimController: ModelController<Claim> {
    
    static let sharedInstance = ClaimController.init(modelType: ModelType.Claim)
    
    func all(eventId: String) -> [Claim] {
        let items = all()
        return items.filter{$0.eventId == eventId}
    }
    
    func claimsRatingsHash(eventId: String) -> [String:Int] {
        let items = all(eventId:eventId)
        var hash: [String:Int] = [:]
        for claim: Claim in items {
            hash[claim.claimId] = RatingController.sharedInstance.latestRating(modelId: claim.claimId)
        }
        return hash
    }
    
    func claimsAggRatingsHash(eventId: String) -> [String:Int] {
        let items = all(eventId:eventId)
        var hash: [String:Int] = [:]
        for claim: Claim in items {
            hash[claim.claimId] = RatingController.sharedInstance.averageRating(modelId: claim.claimId)
        }
        return hash
    }
    
    override func loadDefault() {
        let events = EventController.sharedInstance.all(category: .World)
        let event: Event? = events.first
        if let event = event {
            let claimFactory = ClaimFactory()
            let claim1 = claimFactory.create(title: "The Plane Crashed", summary: "Your probablity: 60%", creationDate: Date(), url: "", eventId: event.eventId)
            update(key: claim1.claimId, item: claim1)
            let claim2 = claimFactory.create(title: "High Jacked", summary: "Your probablity: 45%", creationDate: Date(), url: "", eventId: event.eventId)
            update(key: claim2.claimId, item: claim2)
            let claim3 = claimFactory.create(title: "The Plane was Stolen", summary: "Your probablity: 70%", creationDate: Date(), url: "", eventId: event.eventId)
            update(key: claim3.claimId, item: claim3)
        }
    }
}

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
    
    override func loadDefault() {
        let users = UserController.sharedInstance.all()
        var user = users.first!
        var events = EventController.sharedInstance.all(category: .World)
        var event: Event? = events.first
        let claimFactory = ClaimFactory()
        if let event = event {
            let claim1 = claimFactory.create(title: "The Plane Crashed", summary: "Your probablity: 60%", creationDate: Date(), url: "", eventId: event.eventId, userId: user.userId)
            update(key: claim1.claimId, item: claim1)
            let claim2 = claimFactory.create(title: "High Jacked", summary: "Your probablity: 45%", creationDate: Date(), url: "", eventId: event.eventId, userId: user.userId)
            update(key: claim2.claimId, item: claim2)
            let claim3 = claimFactory.create(title: "The Plane was Stolen", summary: "Your probablity: 70%", creationDate: Date(), url: "", eventId: event.eventId, userId: user.userId)
            update(key: claim3.claimId, item: claim3)
        }
        events = EventController.sharedInstance.all(category: .Sports)
        event = events.first
        user = users.last!
        if let event = event {
            let claim4 = claimFactory.create(title: "Fabricated His Story", summary: "Your probablity: 60%", creationDate: Date(), url: "", eventId: event.eventId, userId: user.userId)
            update(key: claim4.claimId, item: claim4)
            let claim5 = claimFactory.create(title: "Robbed by Guards", summary: "Your probablity: 70%", creationDate: Date(), url: "", eventId: event.eventId, userId: user.userId)
            update(key: claim5.claimId, item: claim5)
        }
    }
}

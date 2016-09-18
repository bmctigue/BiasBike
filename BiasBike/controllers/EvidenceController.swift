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
    
    override func loadDefault() {
        let events = EventController.sharedInstance.all(category: .World)
        let event: Event? = events.first
        let claims = ClaimController.sharedInstance.all(eventId: (event?.eventId)!)
        let claim: Claim? = claims.first
        let evidenceFactory = EvidenceFactory()
        let evidence1 = evidenceFactory.create(title: "Wing Debris", summary: "", creationDate: Date(), url: "debris", relevance: 50, reliability: 50, aggRR: 35, claimId: (claim?.claimId)!)
        update(key: evidence1.evidenceId, item: evidence1)
        let evidence2 = evidenceFactory.create(title: "Flight path", summary: "", creationDate: Date(), url: "flightpath", relevance: 50, reliability: 50, aggRR: 65, claimId: (claim?.claimId)!)
        update(key: evidence2.evidenceId, item: evidence2)
    }
}

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
    
    override func loadDefault() {
        clear()
        let events = EventController.sharedInstance.all(category: .World)
        let event = events.first
        let claimFactory = ClaimFactory()
        let claim1 = claimFactory.create(title: "The Plane Crashed", summary: "Your probablity: 60%", creationDate: Date(), url: "", probability: 60, aggProbability: 40, eventId: (event?.eventId)!)
        update(key: claim1.claimId, item: claim1)
        let claim2 = claimFactory.create(title: "High Jacked", summary: "Your probablity: 45%", creationDate: Date(), url: "", probability: 45, aggProbability: 70, eventId: (event?.eventId)!)
        update(key: claim2.claimId, item: claim2)
        let claim3 = claimFactory.create(title: "The Plane was Stolen", summary: "Your probablity: 70%", creationDate: Date(), url: "", probability: 70, aggProbability: 90, eventId: (event?.eventId)!)
        update(key: claim3.claimId, item: claim3)
    }
}

//
//  ClaimController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/31/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

class ClaimController: ModelController<Claim> {
    
    static let sharedInstance = ClaimController.init(modelType: ModelType.Claim)
    
    override func loadDefault() {
        clear()
        let claimFactory = ClaimFactory()
        let claim1 = claimFactory.create(title: "The Plane Crashed", summary: "", creationDate: Date(), url: "", probability: 70, aggProbability: 50)
        update(key: claim1.claimId, item: claim1)
        let claim2 = claimFactory.create(title: "High Jacked", summary: "", creationDate: Date(), url: "", probability: 45, aggProbability: 65)
        update(key: claim2.claimId, item: claim2)
        let claim3 = claimFactory.create(title: "The Plane was Stolen", summary: "", creationDate: Date(), url: "", probability: 90, aggProbability: 70)
        update(key: claim3.claimId, item: claim3)
    }
}

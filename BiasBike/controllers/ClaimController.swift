//
//  ClaimController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/31/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

class ClaimController: ModelController<Claim> {
    
    static let sharedInstance = EvidenceController.init(modelType: ModelType.Claim)
    
    let modelController = ModelController<Claim>.init(modelType: ModelType.Claim)
    
    override func all() -> [Claim] {
        return modelController.all()
    }
    
    override func add(item: Claim) {
        modelController.add(item: item)
    }
    
    override func loadDefault() {
        clear()
        let claim1 = Claim(claimId: "1", title: "The Plane Crashed", summary: "", creationDate: Date(), url: "", probability: 70, aggProbability: 50)
        add(item: claim1)
        let claim2 = Claim(claimId: "2", title: "High Jacked", summary: "", creationDate: Date(), url: "", probability: 45, aggProbability: 65)
        add(item: claim2)
        let claim3 = Claim(claimId: "3", title: "The Plane was Stolen", summary: "", creationDate: Date(), url: "", probability: 90, aggProbability: 70)
        add(item: claim3)
    }
}

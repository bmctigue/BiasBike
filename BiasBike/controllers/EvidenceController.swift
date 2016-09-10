//
//  EvidenceController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/1/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

class EvidenceController: ModelController<Evidence> {
    
    static let sharedInstance = EvidenceController.init(modelType: ModelType.Evidence)
    
    let modelController = ModelController<Evidence>.init(modelType: ModelType.Evidence)
    
    override func all() -> [Evidence] {
        return modelController.all()
    }
    
    override func add(item: Evidence) {
        modelController.add(item: item)
    }
    
    override func loadDefault() {
        clear()
        let evidence1 = Evidence(evidenceId: "1", title: "Wing Debris", summary: "", creationDate: Date(), url: "", relevance: 45, reliability: 70, aggRR: 50)
        add(item: evidence1)
        let evidence2 = Evidence(evidenceId: "2", title: "Flight path", summary: "", creationDate: Date(), url: "", relevance: 35, reliability: 45, aggRR: 65)
        add(item: evidence2)
    }
}

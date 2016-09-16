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
    
    override func loadDefault() {
        clear()
        let evidenceFactory = EvidenceFactory()
        let evidence1 = evidenceFactory.create(title: "Wing Debris", summary: "", creationDate: Date(), url: "", relevance: 45, reliability: 70, aggRR: 50)
        update(key: evidence1.evidenceId, item: evidence1)
        let evidence2 = evidenceFactory.create(title: "Flight path", summary: "", creationDate: Date(), url: "", relevance: 35, reliability: 45, aggRR: 65)
        update(key: evidence2.evidenceId, item: evidence2)
    }
}

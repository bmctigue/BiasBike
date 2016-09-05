//
//  EvidenceFactory.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/5/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

protocol EvidenceFactoryProtocol {
    func create(evidenceId: String, title: String, summary: String, creationDate: Date, url: String, relevance: Int, reliability: Int, aggRR: Int) -> Evidence
}

struct EvidenceFactory: EvidenceFactoryProtocol {
    func create(evidenceId: String, title: String, summary: String, creationDate: Date, url: String, relevance: Int, reliability: Int, aggRR: Int) -> Evidence {
        return Evidence.init(evidenceId: evidenceId, title: title, summary: summary, creationDate: creationDate, url: url, relevance: relevance, reliability: reliability, aggRR: aggRR)
    }
}

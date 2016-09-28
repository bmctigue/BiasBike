//
//  EvidenceFactory.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/5/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

protocol EvidenceFactoryProtocol {
    func create(title: String, summary: String, url: String, claimId: String, userId: String) -> Evidence
}

struct EvidenceFactory: EvidenceFactoryProtocol {
    func create(title: String, summary: String, url: String, claimId: String, userId: String) -> Evidence {
        return Evidence(value: [title: title, summary: summary, url: url, claimId: claimId, userId: userId])
    }
}

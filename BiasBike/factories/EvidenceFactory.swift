//
//  EvidenceFactory.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/5/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift

protocol EvidenceFactoryProtocol {
    func create(title: String, summary: String, url: String, claim: Claim, userId: String) -> Evidence
}

struct EvidenceFactory: EvidenceFactoryProtocol {
    func create(title: String, summary: String, url: String, claim: Claim, userId: String) -> Evidence {
        let evidence = Evidence(value: ["title": title, "summary": summary, "url": url, "userId": userId])
        evidence.claim = claim
        let realm = try! Realm()
        try! realm.write {
            claim.evidence.append(evidence)
        }
        return evidence
    }
}

//
//  ClaimFactory.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/5/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift

protocol ClaimFactoryProtocol {
    func create(title: String, summary: String, url: String, event: Event, userId: String) -> Claim
}

struct ClaimFactory: ClaimFactoryProtocol {
    func create(title: String, summary: String, url: String, event: Event, userId: String) -> Claim {
        let claim = Claim(value: ["title": title, "summary": summary, "url": url, "userId": userId])
        claim.event = event
        let realm = try! Realm()
        try! realm.write {
            realm.add(claim)
            event.claims.append(claim)
        }
        return claim
    }
}

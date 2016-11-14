//
//  Claim.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/31/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

import RealmSwift

final class Claim: Object {
    dynamic var claimId: String = NSUUID().uuidString
    dynamic var title: String = ""
    dynamic var summary: String = ""
    dynamic var creationDate: Date = Date()
    dynamic var url: String = ""
    dynamic var event: Event?
    dynamic var userId: String = ""
    let evidence = List<Evidence>()
    
    override static func indexedProperties() -> [String] {
        return ["claimId", "creationDate"]
    }
    
    override static func primaryKey() -> String? {
        return "claimId"
    }
    
}

//
//  Evidence.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/1/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift

final class Evidence: Object {
    dynamic var evidenceId: String = NSUUID().uuidString
    dynamic var title: String = ""
    dynamic var summary: String = ""
    dynamic var creationDate: Date = Date()
    dynamic var url: String = ""
    dynamic var claimId: String = ""
    dynamic var userId: String = ""
    let fallacies = List<Fallacy>()
    
    override static func indexedProperties() -> [String] {
        return ["evidenceId", "creationDate"]
    }
    
    override static func primaryKey() -> String? {
        return "evidenceId"
    }
}

//
//  Fallacy.swift
//  BiasBike
//
//  Created by Bruce McTigue on 10/1/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift

enum FallacIcons: String {
    case AnonymousAuthority = "olderman"
    case Anger = "angry"
    case Authority = "police"
}

final class Fallacy: Object {
    dynamic var fallacyId: String = NSUUID().uuidString
    dynamic var title: String = ""
    dynamic var summary: String = ""
    dynamic var example: String = ""
    dynamic var creationDate: Date = Date()
    dynamic var url: String = ""
    dynamic var icon: String = ""
    
    override static func indexedProperties() -> [String] {
        return ["fallacyId", "creationDate"]
    }
    
    override static func primaryKey() -> String? {
        return "fallacyId"
    }
    
}

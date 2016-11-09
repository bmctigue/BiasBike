//
//  Event.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/30/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift

final class Event: Object {
    dynamic var eventId: String = NSUUID().uuidString
    dynamic var title: String = ""
    dynamic var summary: String = ""
    dynamic var creationDate: Date = Date()
    dynamic var url: String = ""
    dynamic var photoUrl: String = ""
    dynamic var category: String = ""
    let claims = List<Claim>()
    
    override static func indexedProperties() -> [String] {
        return ["eventId", "creationDate"]
    }
    
    override static func primaryKey() -> String? {
        return "eventId"
    }
    
}

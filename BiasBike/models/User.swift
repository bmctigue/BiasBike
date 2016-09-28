//
//  User.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/2/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift

final class User: Object {
    dynamic var userId: String = NSUUID().uuidString
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var email: String = ""
    dynamic var creationDate: Date = Date()
    dynamic var url: String = ""
    
    override static func indexedProperties() -> [String] {
        return ["userId", "creationDate"]
    }
    
    override static func primaryKey() -> String? {
        return "userId"
    }
    
}

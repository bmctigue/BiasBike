//
//  Fallacy.swift
//  BiasBike
//
//  Created by Bruce McTigue on 10/1/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift

protocol FallacyProtocol {
    var fallacyId: String { get }
    var creationDate: Date { get }
    var title: String { get }
    var summary: String { get }
    var example: String { get }
    var icon: String { get }
    var type: String { get }
}

class Fallacy: Object, FallacyProtocol {
    dynamic var fallacyId: String = NSUUID().uuidString
    dynamic var creationDate: Date = Date()
    dynamic var title: String = ""
    dynamic var summary: String = ""
    dynamic var example: String = ""
    dynamic var icon: String = ""
    dynamic var type: String = ""
    
    override static func indexedProperties() -> [String] {
        return ["fallacyId", "creationDate"]
    }
    
    override static func primaryKey() -> String? {
        return "fallacyId"
    }
    
}

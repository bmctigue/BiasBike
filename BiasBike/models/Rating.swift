//
//  Rating.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/19/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift

class Rating: Object{
    dynamic var ratingId: String = NSUUID().uuidString
    dynamic var creationDate: Date = Date()
    dynamic var rating: Int = 0
    dynamic var modelId: String = ""
    dynamic var userId: String = ""
    
    override static func indexedProperties() -> [String] {
        return ["ratingId", "creationDate"]
    }
    
    override static func primaryKey() -> String? {
        return "ratingId"
    }
    
}

final class RelevanceRating: Rating {}

final class ReliabilityRating: Rating {}

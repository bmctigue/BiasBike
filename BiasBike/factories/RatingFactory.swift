//
//  RatingFactory.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/20/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift

protocol RatingFactoryProtocol {
    func create(rating: Int, modelId: String, userId: String) -> Rating
}

struct RatingFactory: RatingFactoryProtocol {
    func create(rating: Int, modelId: String, userId: String) -> Rating {
        let rating = Rating(value: ["rating": rating, "modelId": modelId, "userId": userId])
        let realm = try! Realm()
        try! realm.write {
            realm.add(rating)
        }
        return rating
    }
}

struct RelevanceRatingFactory: RatingFactoryProtocol {
    func create(rating: Int, modelId: String, userId: String) -> Rating {
        let rating = RelevanceRating(value: ["rating": rating, "modelId": modelId, "userId": userId])
        let realm = try! Realm()
        try! realm.write {
            realm.add(rating)
        }
        return rating
    }
}

struct ReliabilityRatingFactory: RatingFactoryProtocol {
    func create(rating: Int, modelId: String, userId: String) -> Rating {
        let rating = ReliabilityRating(value: ["rating": rating, "modelId": modelId, "userId": userId])
        let realm = try! Realm()
        try! realm.write {
            realm.add(rating)
        }
        return rating
    }
}

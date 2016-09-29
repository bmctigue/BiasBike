//
//  RatingFactory.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/20/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

protocol RatingFactoryProtocol {
    func create(rating: Int, modelId: String, userId: String) -> Rating
}

struct RatingFactory: RatingFactoryProtocol {
    func create(rating: Int, modelId: String, userId: String) -> Rating {
        return Rating(value: ["rating": rating, "modelId": modelId, "userId": userId])
    }
}

struct RelevanceRatingFactory: RatingFactoryProtocol {
    func create(rating: Int, modelId: String, userId: String) -> Rating {
        return RelevanceRating(value: ["rating": rating, "modelId": modelId, "userId": userId])
    }
}

struct ReliabilityRatingFactory: RatingFactoryProtocol {
    func create(rating: Int, modelId: String, userId: String) -> Rating {
        return ReliabilityRating(value: ["rating": rating, "modelId": modelId, "userId": userId])
    }
}

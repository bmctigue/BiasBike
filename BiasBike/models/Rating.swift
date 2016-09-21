//
//  Rating.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/19/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

class Rating: NSObject, NSCoding {
    private(set) var ratingId: String
    private(set) var creationDate: Date
    var rating: Int
    private(set) var modelId: String
    private(set) var userId: String
    
    init(creationDate: Date, rating: Int, modelId: String, userId: String) {
        self.ratingId = NSUUID().uuidString
        self.creationDate = creationDate
        self.rating = rating
        self.modelId = modelId
        self.userId = userId
        super.init()
    }
    
    init(ratingId: String, creationDate: Date, rating: Int, modelId: String, userId: String) {
        self.ratingId = ratingId
        self.creationDate = creationDate
        self.rating = rating
        self.modelId = modelId
        self.userId = userId
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let ratingId = aDecoder.decodeObject(forKey: Keys.RatingId.rawValue) as! String
        let creationDate = aDecoder.decodeObject(forKey: Keys.CreationDate.rawValue) as! Date
        let rating = aDecoder.decodeInteger(forKey: Keys.Rating.rawValue)
        let modelId = aDecoder.decodeObject(forKey: Keys.ModelId.rawValue) as! String
        let userId = aDecoder.decodeObject(forKey: Keys.UserId.rawValue) as! String
        self.init(ratingId:ratingId, creationDate: creationDate, rating: rating, modelId: modelId, userId: userId)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(ratingId, forKey: Keys.RatingId.rawValue)
        aCoder.encode(creationDate, forKey: Keys.CreationDate.rawValue)
        aCoder.encode(rating, forKey: Keys.Rating.rawValue)
        aCoder.encode(modelId, forKey: Keys.ModelId.rawValue)
        aCoder.encode(modelId, forKey: Keys.UserId.rawValue)
    }
    
    enum Keys: String {
        case RatingId = "ratingId"
        case CreationDate = "creationDate"
        case Rating = "rating"
        case ModelId = "modelId"
        case UserId = "userId"
    }
}

final class RelevanceRating: Rating {
    
    required convenience init?(coder aDecoder: NSCoder) {
        let ratingId = aDecoder.decodeObject(forKey: Keys.RatingId.rawValue) as! String
        let creationDate = aDecoder.decodeObject(forKey: Keys.CreationDate.rawValue) as! Date
        let rating = aDecoder.decodeInteger(forKey: Keys.Rating.rawValue)
        let modelId = aDecoder.decodeObject(forKey: Keys.ModelId.rawValue) as! String
        let userId = aDecoder.decodeObject(forKey: Keys.UserId.rawValue) as! String
        self.init(ratingId:ratingId, creationDate: creationDate, rating: rating, modelId: modelId, userId: userId)
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
    }
}

final class ReliabilityRating: Rating {
    
    required convenience init?(coder aDecoder: NSCoder) {
        let ratingId = aDecoder.decodeObject(forKey: Keys.RatingId.rawValue) as! String
        let creationDate = aDecoder.decodeObject(forKey: Keys.CreationDate.rawValue) as! Date
        let rating = aDecoder.decodeInteger(forKey: Keys.Rating.rawValue)
        let modelId = aDecoder.decodeObject(forKey: Keys.ModelId.rawValue) as! String
        let userId = aDecoder.decodeObject(forKey: Keys.UserId.rawValue) as! String
        self.init(ratingId:ratingId, creationDate: creationDate, rating: rating, modelId: modelId, userId: userId)
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
    }
}

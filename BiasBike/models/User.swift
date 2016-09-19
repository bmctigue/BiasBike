//
//  User.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/2/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

final class User: NSObject, NSCoding {
    private(set) var userId: String
    private(set) var firstName: String
    private(set) var lastName: String
    private(set) var creationDate: Date
    private(set) var url: String
    private(set) var rtRating: Int
    private(set) var aggRR: Int
    
    init(firstName: String, lastName: String, creationDate: Date, url: String, rtRating: Int, aggRR: Int) {
        self.userId = NSUUID().uuidString
        self.firstName = firstName
        self.lastName = lastName
        self.creationDate = creationDate
        self.url = url
        self.rtRating = rtRating
        self.aggRR = aggRR
        super.init()
    }
    
    private init(userId: String, firstName: String, lastName: String, creationDate: Date, url: String, rtRating: Int, aggRR: Int) {
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.creationDate = creationDate
        self.url = url
        self.rtRating = rtRating
        self.aggRR = aggRR
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let userId = aDecoder.decodeObject(forKey: Keys.UserId.rawValue) as! String
        let firstName = aDecoder.decodeObject(forKey: Keys.FirstName.rawValue) as! String
        let lastName = aDecoder.decodeObject(forKey: Keys.LastName.rawValue) as! String
        let creationDate = aDecoder.decodeObject(forKey: Keys.CreationDate.rawValue) as! Date
        let url = aDecoder.decodeObject(forKey: Keys.Url.rawValue) as! String
        let rtRating = aDecoder.decodeInteger(forKey: Keys.RtRating.rawValue)
        let aggRR = aDecoder.decodeInteger(forKey: Keys.AggRR.rawValue)
        self.init(userId:userId, firstName: firstName, lastName: lastName, creationDate: creationDate, url: url, rtRating: rtRating, aggRR: aggRR)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userId, forKey: Keys.UserId.rawValue)
        aCoder.encode(firstName, forKey: Keys.FirstName.rawValue)
        aCoder.encode(lastName, forKey: Keys.LastName.rawValue)
        aCoder.encode(creationDate, forKey: Keys.CreationDate.rawValue)
        aCoder.encode(url, forKey: Keys.Url.rawValue)
        aCoder.encode(rtRating, forKey: Keys.RtRating.rawValue)
        aCoder.encode(aggRR, forKey: Keys.AggRR.rawValue)
    }
    
    enum Keys: String {
        case UserId = "userId"
        case FirstName = "firstName"
        case LastName = "lastName"
        case CreationDate = "creationDate"
        case Url = "url"
        case RtRating = "rtRating"
        case AggRR = "aggRR"
    }
}

//
//  Claim.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/31/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

final class Claim: NSObject, NSCoding {
    private(set) var claimId: String
    private(set) var title: String
    private(set) var summary: String
    private(set) var creationDate: Date
    private(set) var url: String
    private(set) var eventId: String
    private(set) var userId: String
    
    init(title: String, summary: String, creationDate: Date, url: String, eventId: String, userId: String) {
        self.claimId = NSUUID().uuidString
        self.title = title
        self.summary = summary
        self.creationDate = creationDate
        self.url = url
        self.eventId = eventId
        self.userId = userId
        super.init()
    }
    
    private init(claimId: String, title: String, summary: String, creationDate: Date, url: String, eventId: String, userId: String) {
        self.claimId = claimId
        self.title = title
        self.summary = summary
        self.creationDate = creationDate
        self.url = url
        self.eventId = eventId
        self.userId = userId
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let claimId = aDecoder.decodeObject(forKey: Keys.claimId.rawValue) as! String
        let title = aDecoder.decodeObject(forKey: Keys.Title.rawValue) as! String
        let summary = aDecoder.decodeObject(forKey: Keys.Summary.rawValue) as! String
        let creationDate = aDecoder.decodeObject(forKey: Keys.CreationDate.rawValue) as! Date
        let url = aDecoder.decodeObject(forKey: Keys.Url.rawValue) as! String
        let eventId = aDecoder.decodeObject(forKey: Keys.EventId.rawValue) as! String
        let userId = aDecoder.decodeObject(forKey: Keys.UserId.rawValue) as! String
        self.init(claimId:claimId, title: title, summary: summary, creationDate: creationDate, url: url, eventId: eventId, userId: userId)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(claimId, forKey: Keys.claimId.rawValue)
        aCoder.encode(title, forKey: Keys.Title.rawValue)
        aCoder.encode(summary, forKey: Keys.Summary.rawValue)
        aCoder.encode(creationDate, forKey: Keys.CreationDate.rawValue)
        aCoder.encode(url, forKey: Keys.Url.rawValue)
        aCoder.encode(eventId, forKey: Keys.EventId.rawValue)
        aCoder.encode(userId, forKey: Keys.UserId.rawValue)
    }
    
    enum Keys: String {
        case claimId = "claimId"
        case Title = "title"
        case Summary = "summary"
        case CreationDate = "creationDate"
        case Url = "url"
        case EventId = "eventId"
        case UserId = "userId"
    }
}

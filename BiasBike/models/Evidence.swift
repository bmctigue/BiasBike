//
//  Evidence.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/1/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

final class Evidence: NSObject, NSCoding {
    private(set) var evidenceId: String
    private(set) var title: String
    private(set) var summary: String
    private(set) var creationDate: Date
    private(set) var url: String
    private(set) var claimId: String
    private(set) var userId: String
    
    init(title: String, summary: String, creationDate: Date, url: String, claimId: String, userId: String) {
        self.evidenceId = NSUUID().uuidString
        self.title = title
        self.summary = summary
        self.creationDate = creationDate
        self.url = url
        self.claimId = claimId
        self.userId = userId
        super.init()
    }
    
    private init(evidenceId: String, title: String, summary: String, creationDate: Date, url: String, claimId: String, userId: String) {
        self.evidenceId = evidenceId
        self.title = title
        self.summary = summary
        self.creationDate = creationDate
        self.url = url
        self.claimId = claimId
        self.userId = userId
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let evidenceId = aDecoder.decodeObject(forKey: Keys.EvidenceId.rawValue) as! String
        let title = aDecoder.decodeObject(forKey: Keys.Title.rawValue) as! String
        let summary = aDecoder.decodeObject(forKey: Keys.Summary.rawValue) as! String
        let creationDate = aDecoder.decodeObject(forKey: Keys.CreationDate.rawValue) as! Date
        let url = aDecoder.decodeObject(forKey: Keys.Url.rawValue) as! String
        let claimId = aDecoder.decodeObject(forKey: Keys.ClaimId.rawValue) as! String
        let userId = aDecoder.decodeObject(forKey: Keys.UserId.rawValue) as! String
        self.init(evidenceId:evidenceId, title: title, summary: summary, creationDate: creationDate, url: url, claimId: claimId, userId: userId)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(evidenceId, forKey: Keys.EvidenceId.rawValue)
        aCoder.encode(title, forKey: Keys.Title.rawValue)
        aCoder.encode(summary, forKey: Keys.Summary.rawValue)
        aCoder.encode(creationDate, forKey: Keys.CreationDate.rawValue)
        aCoder.encode(url, forKey: Keys.Url.rawValue)
        aCoder.encode(claimId, forKey: Keys.ClaimId.rawValue)
        aCoder.encode(userId, forKey: Keys.UserId.rawValue)
    }
    
    enum Keys: String {
        case EvidenceId = "evidenceId"
        case Title = "title"
        case Summary = "summary"
        case CreationDate = "creationDate"
        case Url = "url"
        case ClaimId = "claimId"
        case UserId = "userId"
    }
}

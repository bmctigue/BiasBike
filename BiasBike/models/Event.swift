//
//  Event.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/30/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

final class Event: NSObject, NSCoding {
    private(set) var eventId: String
    private(set) var title: String
    private(set) var summary: String
    private(set) var creationDate: Date
    private(set) var url: String
    private(set) var photoUrl: String
    private(set) var category: Category
    
    init(title: String, summary: String, creationDate: Date, url: String, photoUrl: String, category: Category) {
        self.eventId = NSUUID().uuidString
        self.title = title
        self.summary = summary
        self.creationDate = creationDate
        self.url = url
        self.photoUrl = photoUrl
        self.category = category
        super.init()
    }
    
    private init(eventId: String, title: String, summary: String, creationDate: Date, url: String, photoUrl: String, category: Category) {
        self.eventId = eventId
        self.title = title
        self.summary = summary
        self.creationDate = creationDate
        self.url = url
        self.photoUrl = photoUrl
        self.category = category
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let eventId = aDecoder.decodeObject(forKey: Keys.EventID.rawValue) as! String
        let title = aDecoder.decodeObject(forKey: Keys.Title.rawValue) as! String
        let summary = aDecoder.decodeObject(forKey: Keys.Summary.rawValue) as! String
        let creationDate = aDecoder.decodeObject(forKey: Keys.CreationDate.rawValue) as! Date
        let url = aDecoder.decodeObject(forKey: Keys.Url.rawValue) as! String
        let photoUrl = aDecoder.decodeObject(forKey: Keys.PhotoUrl.rawValue) as! String
        let category = Category(rawValue: (aDecoder.decodeObject(forKey: "category") as! String))!
        self.init(eventId:eventId, title: title, summary: summary, creationDate: creationDate, url: url, photoUrl: photoUrl, category: category)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(eventId, forKey: Keys.EventID.rawValue)
        aCoder.encode(title, forKey: Keys.Title.rawValue)
        aCoder.encode(summary, forKey: Keys.Summary.rawValue)
        aCoder.encode(creationDate, forKey: Keys.CreationDate.rawValue)
        aCoder.encode(url, forKey: Keys.Url.rawValue)
        aCoder.encode(photoUrl, forKey: Keys.PhotoUrl.rawValue)
        aCoder.encode(category.rawValue, forKey: Keys.Category.rawValue)
    }
    
    enum Keys: String {
        case EventID = "eventId"
        case Title = "title"
        case Summary = "summary"
        case CreationDate = "creationDate"
        case Url = "url"
        case PhotoUrl = "photoUrl"
        case Category = "category"
    }
}

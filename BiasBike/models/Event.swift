//
//  Event.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/30/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

class Event {
    let id: IntMax
    let title: String
    let summary: String
    let creationDate: Date
    let url: String
    let photoUrl: String
    let category: Category
    
    init(id: IntMax, title: String, summary: String, creationDate: Date, url: String, photoUrl: String, category: Category) {
        self.id = id
        self.title = title
        self.summary = summary
        self.creationDate = creationDate
        self.url = url
        self.photoUrl = photoUrl
        self.category = category
    }
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: Keys.Id.rawValue) as! IntMax
        title = aDecoder.decodeObject(forKey: Keys.Title.rawValue) as! String
        summary = aDecoder.decodeObject(forKey: Keys.Summary.rawValue) as! String
        creationDate = aDecoder.decodeObject(forKey: Keys.CreationDate.rawValue) as! Date
        url = aDecoder.decodeObject(forKey: Keys.Url.rawValue) as! String
        photoUrl = aDecoder.decodeObject(forKey: Keys.PhotoUrl.rawValue) as! String
        category = aDecoder.decodeObject(forKey: Keys.Category.rawValue) as! Category
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encode(id, forKey: Keys.Id.rawValue)
        aCoder.encode(title, forKey: Keys.Title.rawValue)
        aCoder.encode(summary, forKey: Keys.Summary.rawValue)
        aCoder.encode(creationDate, forKey: Keys.CreationDate.rawValue)
        aCoder.encode(url, forKey: Keys.Url.rawValue)
        aCoder.encode(photoUrl, forKey: Keys.PhotoUrl.rawValue)
        aCoder.encode(category, forKey: Keys.Category.rawValue)
    }
    
    enum Keys: String {
        case Id = "id"
        case Title = "title"
        case Summary = "summary"
        case CreationDate = "creationDate"
        case Url = "url"
        case PhotoUrl = "photoUrl"
        case Category = "category"
    }
}

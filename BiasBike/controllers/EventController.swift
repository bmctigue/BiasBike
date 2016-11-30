//
//  EventController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/30/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation
import RealmSwift

final class EventController: ModelController {
    
    static let sharedInstance = EventController.init()
    
    func all() -> [Event] {
        let items = realm.objects(Event.self)
        if items.count == 0 {
            return [Event]()
        }
        return Array(items)
    }
    
    func find(key: String) -> Event? {
        return realm.object(ofType: Event.self, forPrimaryKey: key)
    }
    
    func all(category: Category) -> [Event] {
        let items = all()
        return items.filter{$0.category == category.rawValue}
    }
    
    func categoryHash() -> [String:[Event]] {
        let items = all()
        var eventsArray: [Event]?
        var hash: [String:[Event]] = [:]
        for event in items {
            eventsArray = hash[event.category]
            if eventsArray == nil {
                hash[event.category] = [event]
            } else {
                eventsArray!.append(event)
                hash[event.category] = eventsArray
            }
        }
        return hash
    }
    
    func loadDefault() {
        let eventFactory = EventFactory()
        _ = eventFactory.create(title: "Malaysia Flight 370", summary: "", url: "", photoUrl: "missing-flight", category: Category.World.rawValue)
        _ = eventFactory.create(title: "Ryan Lochte Robbed?", summary: "", url: "", photoUrl: "lochte", category: Category.Sports.rawValue)
        _ = eventFactory.create(title: "Donald Trump Tax Returns", summary: "", url: "", photoUrl: "donald-trump", category: Category.Politics.rawValue)
        _ = eventFactory.create(title: "Obama Visits Far East", summary: "", url: "", photoUrl: "barack_obama", category: Category.Politics.rawValue)
    }
}

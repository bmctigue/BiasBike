//
//  EventController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/30/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

class EventController: ModelController<Event> {
    
    static let sharedInstance = EventController.init(modelType: ModelType.Event)
    
    func all(category: CategoryType) -> [Event] {
        let items = all()
        return items.filter{$0.category == category}
    }
    
    func categoryHash() -> [String:[Event]] {
        let items = all()
        var eventsArray: [Event]?
        var hash: [String:[Event]] = [:]
        for event in items {
            eventsArray = hash[event.category.rawValue]
            if eventsArray == nil {
                hash[event.category.rawValue] = [event]
            } else {
                eventsArray!.append(event)
                hash[event.category.rawValue] = eventsArray
            }
        }
        return hash
    }
    
    override func loadDefault() {
        clear()
        let eventFactory = EventFactory()
        let event1 = eventFactory.create(title: "Malaysia Flight 370", summary: "", creationDate: Date(), url: "", photoUrl: "missing-flight", aggProbability: 70, category: .World)
        update(key: event1.eventId, item: event1)
        let event2 = eventFactory.create(title: "Ryan Lochte Robbed?", summary: "", creationDate: Date(), url: "", photoUrl: "lochte", aggProbability: 40, category: .Sports)
        update(key: event2.eventId, item: event2)
        let event3 = eventFactory.create(title: "Donald Trump Tax Returns", summary: "", creationDate: Date(), url: "", photoUrl: "donald-trump", aggProbability: 55, category: .Politics)
        update(key: event3.eventId, item: event3)
        let event4 = eventFactory.create(title: "Obama Visits Far East", summary: "", creationDate: Date(), url: "", photoUrl: "barack_obama", aggProbability: 55, category: .Politics)
        update(key: event4.eventId, item: event4)
    }
}

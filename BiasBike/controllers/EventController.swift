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
    
    func all(category: Category) -> [Event] {
        let items = all()
        return items.filter{$0.category == category}
    }
    
    override func loadDefault() {
        clear()
        let eventFactory = EventFactory()
        let event1 = eventFactory.create(title: "Malaysia Flight 370", summary: "", creationDate: Date(), url: "", photoUrl: "photoUrl", aggProbability: 70, category: .World)
        update(key: event1.eventId, item: event1)
        let event2 = eventFactory.create(title: "Ryan Lochte Robbed?", summary: "", creationDate: Date(), url: "", photoUrl: "photoUrl", aggProbability: 40, category: .News)
        update(key: event2.eventId, item: event2)
        let event3 = eventFactory.create(title: "Donald Trump Tax Returns", summary: "", creationDate: Date(), url: "", photoUrl: "photoUrl", aggProbability: 55, category: .Politics)
        update(key: event3.eventId, item: event3)
    }
}

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
    
    override func loadDefault() {
        clear()
        let event1 = Event(eventId: "1", title: "Malaysia Flight 370", summary: "", creationDate: Date(), url: "", photoUrl: "photoUrl", category: .World)
        add(item: event1)
        let event2 = Event(eventId: "2", title: "Ryan Lochte Robbed?", summary: "", creationDate: Date(), url: "", photoUrl: "photoUrl", category: .World)
        add(item: event2)
        let event3 = Event(eventId: "3", title: "Donald Trump Tax Returns", summary: "", creationDate: Date(), url: "", photoUrl: "photoUrl", category: .Politics)
        add(item: event3)
    }
}

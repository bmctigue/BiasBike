//
//  EventController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/30/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

class EventController {
    
    static let sharedInstance = EventController()
    private init() {}
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("events")
    
    private(set) var events: [Event] = {
        if let events = NSKeyedUnarchiver.unarchiveObject(withFile: ArchiveURL.path) as? [Event] {
            return events
        } else {
            return [Event]()
        }
    }()
    
    func clearEvents() {
        self.events.removeAll()
    }
    
    func addEvent(event: Event) {
        self.events.append(event)
    }
    
    func save() {
        let castedEvents = self.events as NSArray
        NSKeyedArchiver.archiveRootObject(castedEvents,toFile: EventController.ArchiveURL.path)
    }
}

extension EventController {
    
    func loadDefaultEvents() {
        clearEvents()
        let event1 = Event(eventId: "1", title: "Malaysia Flight 370", summary: "", creationDate: Date(), url: "", photoUrl: "photoUrl", category: .World, claims: [])
        addEvent(event: event1)
        let event2 = Event(eventId: "2", title: "Ryan Lochte Robbed?", summary: "", creationDate: Date(), url: "", photoUrl: "photoUrl", category: .World, claims: [])
        addEvent(event: event2)
        let event3 = Event(eventId: "3", title: "Donald Trump Tax Returns", summary: "", creationDate: Date(), url: "", photoUrl: "photoUrl", category: .Politics, claims: [])
        addEvent(event: event3)
        save()
    }
    
}

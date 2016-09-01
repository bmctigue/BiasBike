//
//  EventControllerTests.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/30/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
@testable import BiasBike

class EventControllerTests: XCTestCase {
    
    var events: [Event] = []
    var testEvent: Event?
    var testEvent2: Event?
    
    override func setUp() {
        super.setUp()
        testEvent = Event(eventId: "1", title: "Test", summary: "Test Summary", creationDate: Date(), url: "", photoUrl: "", category: .Health)
        testEvent2 = Event(eventId: "2", title: "Test2", summary: "Test Summary2", creationDate: Date(), url: "", photoUrl: "", category: .News)
        EventController.sharedInstance.clearEvents()
        EventController.sharedInstance.save()
    }
    
    func testEmptyEvents() {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: EventController.ArchiveURL.path)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        events = EventController.sharedInstance.events
        XCTAssertTrue(events.count == 0)
    }
    
    func testClearEvents() {
        EventController.sharedInstance.addEvent(event: testEvent!)
        EventController.sharedInstance.save()
        EventController.sharedInstance.clearEvents()
        EventController.sharedInstance.save()
        events = EventController.sharedInstance.events
        XCTAssertTrue(events.count == 0)
    }
    
    func testAddEvent() {
        EventController.sharedInstance.addEvent(event: testEvent!)
        EventController.sharedInstance.save()
        events = EventController.sharedInstance.events
        XCTAssertTrue(events.count == 1)
        EventController.sharedInstance.addEvent(event: testEvent2!)
        EventController.sharedInstance.save()
        events = EventController.sharedInstance.events
        XCTAssertTrue(events.count == 2)
    }
    
    func testLoadDefaultEvents() {
        EventController.sharedInstance.loadDefaultEvents()
        let events = EventController.sharedInstance.events
        XCTAssertTrue(events.count == 3)
    }
    
}

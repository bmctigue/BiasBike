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
    var claims: [Claim] = []
    let eventFactory: EventFactoryProtocol = EventFactory()
    
    override func setUp() {
        super.setUp()
        testEvent = eventFactory.create(eventId: "1", title: "Test", summary: "Test Summary", creationDate: Date(), url: "", photoUrl: "", category: .Health, claims: claims)
        testEvent2 = eventFactory.create(eventId: "2", title: "Test2", summary: "Test Summary2", creationDate: Date(), url: "", photoUrl: "", category: .News, claims: claims)
        EventController.sharedInstance.clearEvents()
        EventController.sharedInstance.save()
    }
    
    func testEventInit() {
        let event = eventFactory.create(eventId: "1", title: "Test", summary: "Test Summary", creationDate: Date(), url: "", photoUrl: "", category: .Health, claims: claims)
        XCTAssertTrue(event.eventId == "1")
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

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
    let eventFactory: EventFactoryProtocol = EventFactory()
    
    override func setUp() {
        super.setUp()
        testEvent = eventFactory.create(eventId: "1", title: "Test", summary: "Test Summary", creationDate: Date(), url: "", photoUrl: "", category: .Health)
        testEvent2 = eventFactory.create(eventId: "2", title: "Test2", summary: "Test Summary2", creationDate: Date(), url: "", photoUrl: "", category: .News)
        EventController.sharedInstance.clear()
    }
    
    func testEventInit() {
        let event = eventFactory.create(eventId: "1", title: "Test", summary: "Test Summary", creationDate: Date(), url: "", photoUrl: "", category: .Health)
        XCTAssertTrue(event.eventId == "1")
    }
    
    func testClearEvents() {
        EventController.sharedInstance.add(item: testEvent!)
        EventController.sharedInstance.clear()
        events = EventController.sharedInstance.all()
        XCTAssertTrue(events.count == 0)
    }
    
    func testAddEvent() {
        EventController.sharedInstance.add(item: testEvent!)
        events = EventController.sharedInstance.all()
        XCTAssertTrue(events.count == 1)
        EventController.sharedInstance.add(item: testEvent2!)
        events = EventController.sharedInstance.all()
        XCTAssertTrue(events.count == 2)
    }
    
    func testLoadDefaultEvents() {
        EventController.sharedInstance.loadDefault()
        events = EventController.sharedInstance.all()
        XCTAssertTrue(events.count == 3)
    }
    
}

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
        testEvent = eventFactory.create(title: "Test", summary: "Test Summary", creationDate: Date(), url: "", photoUrl: "", aggProbability: 70, category: .Health)
        testEvent2 = eventFactory.create(title: "Test2", summary: "Test Summary2", creationDate: Date(), url: "", photoUrl: "", aggProbability: 70, category: .News)
        EventController.sharedInstance.clear()
    }
    
    func testEventInit() {
        let event = eventFactory.create(title: "Test", summary: "Test Summary", creationDate: Date(), url: "", photoUrl: "", aggProbability: 70, category: .Health)
        XCTAssertTrue(event.aggProbability == 70)
    }
    
    func testClearEvents() {
        EventController.sharedInstance.update(key: testEvent!.eventId, item: testEvent!)
        EventController.sharedInstance.clear()
        events = EventController.sharedInstance.all()
        XCTAssertTrue(events.count == 0)
    }
    
    func testAddEvent() {
        EventController.sharedInstance.update(key: testEvent!.eventId, item: testEvent!)
        events = EventController.sharedInstance.all()
        XCTAssertTrue(events.count == 1)
        EventController.sharedInstance.update(key: testEvent2!.eventId, item: testEvent2!)
        events = EventController.sharedInstance.all()
        XCTAssertTrue(events.count == 2)
    }
    
    func testLoadDefaultEvents() {
        EventController.sharedInstance.loadDefault()
        events = EventController.sharedInstance.all()
        XCTAssertTrue(events.count == 3)
    }
    
}

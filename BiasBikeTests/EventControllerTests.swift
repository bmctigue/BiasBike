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
        EventController.sharedInstance.clear()
        testEvent = eventFactory.create(title: "Test", summary: "Test Summary", url: "", photoUrl: "", category: Category.World.rawValue)
        testEvent2 = eventFactory.create(title: "Test2", summary: "Test Summary2", url: "", photoUrl: "", category: Category.Sports.rawValue)
    }
    
    func testEventInit() {
        let event = eventFactory.create(title: "Test", summary: "Test Summary", url: "", photoUrl: "", category: Category.Health.rawValue)
        XCTAssertTrue(event.title == "Test")
    }
    
    func testClearEvents() {
        EventController.sharedInstance.clear()
        events = EventController.sharedInstance.all()
        XCTAssertTrue(events.count == 0)
    }
    
    func testFindEvent() {
        let foundEvent = EventController.sharedInstance.find(key: (testEvent?.eventId)!)
        XCTAssertTrue(foundEvent?.title == "Test")
    }
    
    func testLoadDefaultEvents() {
        EventController.sharedInstance.clear()
        EventController.sharedInstance.loadDefault()
        events = EventController.sharedInstance.all()
        XCTAssertTrue(events.count == 4)
    }
    
    func testAllForCategory() {
        EventController.sharedInstance.clear()
        EventController.sharedInstance.loadDefault()
        events = EventController.sharedInstance.all(category:.World)
        XCTAssertTrue(events.count == 1)
        events = EventController.sharedInstance.all(category:.Sports)
        XCTAssertTrue(events.count == 1)
        events = EventController.sharedInstance.all(category:.Politics)
        XCTAssertTrue(events.count == 2)
    }
    
    func testCategoryHash() {
        EventController.sharedInstance.clear()
        EventController.sharedInstance.loadDefault()
        let hash = EventController.sharedInstance.categoryHash()
        XCTAssertEqual(Array(hash.keys).count, 3)
    }
}

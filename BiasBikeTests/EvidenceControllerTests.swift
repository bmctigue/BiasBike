//
//  EvidenceControllerTests.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/1/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
@testable import BiasBike

class EvidenceControllerTests: XCTestCase {
    
    var items: [Evidence] = []
    var testEvidence: Evidence?
    var testEvidence2: Evidence?
    let evidenceFactory: EvidenceFactory = EvidenceFactory()
    
    override func setUp() {
        super.setUp()
        testEvidence = evidenceFactory.create(title: "Wing Debris", summary: "", creationDate: Date(), url: "", claimId: "1")
        testEvidence2 = evidenceFactory.create(title: "Flight path", summary: "", creationDate: Date(), url: "", claimId: "1")
        EvidenceController.sharedInstance.clear()
        EvidenceController.sharedInstance.save()
    }
    
    func testEvidenceInit() {
        let evidence = evidenceFactory.create(title: "Wing Debris", summary: "", creationDate: Date(), url: "", claimId: "1")
        XCTAssertTrue(evidence.title == "Wing Debris")
    }
    
    func testClearEvidence() {
        EvidenceController.sharedInstance.update(key: testEvidence!.evidenceId, item: testEvidence!)
        EvidenceController.sharedInstance.clear()
        EvidenceController.sharedInstance.save()
        items = EvidenceController.sharedInstance.all()
        XCTAssertTrue(items.count == 0)
    }
    
    func testAddEvidence() {
        EvidenceController.sharedInstance.update(key: testEvidence!.evidenceId, item: testEvidence!)
        EvidenceController.sharedInstance.save()
        items = EvidenceController.sharedInstance.all()
        XCTAssertTrue(items.count == 1)
        EvidenceController.sharedInstance.update(key: testEvidence2!.evidenceId, item: testEvidence2!)
        EvidenceController.sharedInstance.save()
        items = EvidenceController.sharedInstance.all()
        XCTAssertTrue(items.count == 2)
    }
    
    func testLoadDefaultEvidence() {
        EventController.sharedInstance.loadDefault()
        EventController.sharedInstance.save()
        ClaimController.sharedInstance.loadDefault()
        ClaimController.sharedInstance.save()
        EvidenceController.sharedInstance.loadDefault()
        EvidenceController.sharedInstance.save()
        let items = EvidenceController.sharedInstance.all()
        XCTAssertTrue(items.count == 2)
    }
    
}

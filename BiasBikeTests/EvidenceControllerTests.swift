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
        testEvidence = evidenceFactory.create(title: "Wing Debris", summary: "", creationDate: Date(), url: "", relevance: 45, reliability: 70, aggRR: 50)
        testEvidence2 = evidenceFactory.create(title: "Flight path", summary: "", creationDate: Date(), url: "", relevance: 35, reliability: 45, aggRR: 65)
        EvidenceController.sharedInstance.clear()
    }
    
    func testEvidenceInit() {
        let evidence = evidenceFactory.create(title: "Wing Debris", summary: "", creationDate: Date(), url: "", relevance: 45, reliability: 70, aggRR: 50)
        XCTAssertTrue(evidence.relevance == 45)
    }
    
    func testClearEvidence() {
        EvidenceController.sharedInstance.update(key: testEvidence!.evidenceId, item: testEvidence!)
        EvidenceController.sharedInstance.clear()
        items = EvidenceController.sharedInstance.all()
        XCTAssertTrue(items.count == 0)
    }
    
    func testaddEvidence() {
        EvidenceController.sharedInstance.update(key: testEvidence!.evidenceId, item: testEvidence!)
        items = EvidenceController.sharedInstance.all()
        XCTAssertTrue(items.count == 1)
        EvidenceController.sharedInstance.update(key: testEvidence2!.evidenceId, item: testEvidence2!)
        items = EvidenceController.sharedInstance.all()
        XCTAssertTrue(items.count == 2)
    }
    
    func testLoadDefaultEvidence() {
        EvidenceController.sharedInstance.loadDefault()
        let items = EvidenceController.sharedInstance.all()
        XCTAssertTrue(items.count == 2)
    }
    
}

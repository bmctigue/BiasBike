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
        testEvidence = evidenceFactory.create(evidenceId: "1", title: "Wing Debris", summary: "", creationDate: Date(), url: "", relevance: 45, reliability: 70, aggRR: 50)
        testEvidence2 = evidenceFactory.create(evidenceId: "2", title: "Flight path", summary: "", creationDate: Date(), url: "", relevance: 35, reliability: 45, aggRR: 65)
        EvidenceController.sharedInstance.clearEvidence()
        EvidenceController.sharedInstance.save()
    }
    
    func testEvidenceInit() {
        let evidence = evidenceFactory.create(evidenceId: "1", title: "Wing Debris", summary: "", creationDate: Date(), url: "", relevance: 45, reliability: 70, aggRR: 50)
        XCTAssertTrue(evidence.evidenceId == "1")
    }
    
    func testEmptyitems() {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: EvidenceController.ArchiveURL.path)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        items = EvidenceController.sharedInstance.items
        XCTAssertTrue(items.count == 0)
    }
    
    func testClearEvidence() {
        EvidenceController.sharedInstance.addEvidence(evidence: testEvidence!)
        EvidenceController.sharedInstance.save()
        EvidenceController.sharedInstance.clearEvidence()
        EvidenceController.sharedInstance.save()
        items = EvidenceController.sharedInstance.items
        XCTAssertTrue(items.count == 0)
    }
    
    func testaddEvidence() {
        EvidenceController.sharedInstance.addEvidence(evidence: testEvidence!)
        EvidenceController.sharedInstance.save()
        items = EvidenceController.sharedInstance.items
        XCTAssertTrue(items.count == 1)
        EvidenceController.sharedInstance.addEvidence(evidence: testEvidence2!)
        EvidenceController.sharedInstance.save()
        items = EvidenceController.sharedInstance.items
        XCTAssertTrue(items.count == 2)
    }
    
    func testLoadDefaultEvidence() {
        EvidenceController.sharedInstance.loadDefaultEvidence()
        let items = EvidenceController.sharedInstance.items
        XCTAssertTrue(items.count == 2)
    }
    
}

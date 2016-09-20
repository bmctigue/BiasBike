//
//  ClaimControllerTests.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/31/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import XCTest
@testable import BiasBike

class ClaimControllerTests: XCTestCase {
    
    var claims: [Claim] = []
    var testClaim: Claim?
    var testClaim2: Claim?
    let claimFactory: ClaimFactoryProtocol = ClaimFactory()
    
    override func setUp() {
        super.setUp()
        testClaim = claimFactory.create(title: "The Plane Crashed", summary: "", creationDate: Date(), url: "", eventId: "1")
        testClaim2 = claimFactory.create(title: "High Jacked", summary: "", creationDate: Date(), url: "", eventId: "1")
        ClaimController.sharedInstance.clear()
        ClaimController.sharedInstance.save()
    }
    
    func testClaimInit() {
        let claim = claimFactory.create(title: "The Plane Crashed", summary: "", creationDate: Date(), url: "", eventId: "1")
        XCTAssertTrue(claim.title == "The Plane Crashed")
    }
    
    func testClearClaims() {
        ClaimController.sharedInstance.update(key: testClaim!.claimId, item: testClaim!)
        ClaimController.sharedInstance.clear()
        ClaimController.sharedInstance.save()
        claims = ClaimController.sharedInstance.all()
        XCTAssertTrue(claims.count == 0)
    }
    
    func testAddClaim() {
        ClaimController.sharedInstance.update(key: testClaim!.claimId, item: testClaim!)
        ClaimController.sharedInstance.save()
        claims = ClaimController.sharedInstance.all()
        XCTAssertTrue(claims.count == 1)
        ClaimController.sharedInstance.update(key: testClaim2!.claimId, item: testClaim2!)
        ClaimController.sharedInstance.save()
        claims = ClaimController.sharedInstance.all()
        XCTAssertTrue(claims.count == 2)
    }
    
    func testLoadDefaultClaims() {
        ClaimController.sharedInstance.loadDefault()
        ClaimController.sharedInstance.save()
        let claims = ClaimController.sharedInstance.all()
        XCTAssertTrue(claims.count == 3)
    }

    
}

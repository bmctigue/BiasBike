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
        testClaim = claimFactory.create(claimId: "1", title: "The Plane Crashed", summary: "", creationDate: Date(), url: "", probability: 70, aggProbability: 50)
        testClaim2 = claimFactory.create(claimId: "2", title: "High Jacked", summary: "", creationDate: Date(), url: "", probability: 45, aggProbability: 65)
        ClaimController.sharedInstance.clear()
    }
    
    func testClaimInit() {
        let claim = claimFactory.create(claimId: "1", title: "The Plane Crashed", summary: "", creationDate: Date(), url: "", probability: 70, aggProbability: 50)
        XCTAssertTrue(claim.claimId == "1")
    }
    
    func testClearClaims() {
        ClaimController.sharedInstance.add(item: testClaim!)
        ClaimController.sharedInstance.clear()
        claims = ClaimController.sharedInstance.all()
        XCTAssertTrue(claims.count == 0)
    }
    
    func testaddClaim() {
        ClaimController.sharedInstance.add(item: testClaim!)
        claims = ClaimController.sharedInstance.all()
        XCTAssertTrue(claims.count == 1)
        ClaimController.sharedInstance.add(item: testClaim2!)
        claims = ClaimController.sharedInstance.all()
        XCTAssertTrue(claims.count == 2)
    }
    
    func testLoadDefaultclaims() {
        ClaimController.sharedInstance.loadDefault()
        let claims = ClaimController.sharedInstance.all()
        XCTAssertTrue(claims.count == 3)
    }

    
}

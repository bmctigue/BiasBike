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
    
    override func setUp() {
        super.setUp()
        testClaim = Claim(claimId: "1", title: "The Plane Crashed", summary: "", creationDate: Date(), url: "", probability: 70, aggProbability: 50, eventId: "1")
        testClaim2 = Claim(claimId: "2", title: "High Jacked", summary: "", creationDate: Date(), url: "", probability: 45, aggProbability: 65, eventId: "1")
        ClaimController.sharedInstance.clearClaims()
        ClaimController.sharedInstance.save()
    }
    
    func testEmptyclaims() {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: ClaimController.ArchiveURL.path)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        claims = ClaimController.sharedInstance.claims
        XCTAssertTrue(claims.count == 0)
    }
    
    func testClearClaims() {
        ClaimController.sharedInstance.addClaim(claim: testClaim!)
        ClaimController.sharedInstance.save()
        ClaimController.sharedInstance.clearClaims()
        ClaimController.sharedInstance.save()
        claims = ClaimController.sharedInstance.claims
        XCTAssertTrue(claims.count == 0)
    }
    
    func testaddClaim() {
        ClaimController.sharedInstance.addClaim(claim: testClaim!)
        ClaimController.sharedInstance.save()
        claims = ClaimController.sharedInstance.claims
        XCTAssertTrue(claims.count == 1)
        ClaimController.sharedInstance.addClaim(claim: testClaim2!)
        ClaimController.sharedInstance.save()
        claims = ClaimController.sharedInstance.claims
        XCTAssertTrue(claims.count == 2)
    }
    
    func testLoadDefaultclaims() {
        ClaimController.sharedInstance.loadDefaultClaims()
        let claims = ClaimController.sharedInstance.claims
        XCTAssertTrue(claims.count == 3)
    }

    
}

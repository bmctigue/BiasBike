//
//  ClaimController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/31/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

class ClaimController {
    
    static let sharedInstance = ClaimController()
    private init() {}
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("claims")
    
    private(set) var claims: [Claim] = {
        if let claims = NSKeyedUnarchiver.unarchiveObject(withFile: ArchiveURL.path) as? [Claim] {
            return claims
        } else {
            return [Claim]()
        }
    }()
    
    func clearClaims() {
        self.claims.removeAll()
    }
    
    func addClaim(claim: Claim) {
        self.claims.append(claim)
    }
    
    func save() {
        let castedEvents = self.claims as NSArray
        NSKeyedArchiver.archiveRootObject(castedEvents,toFile: ClaimController.ArchiveURL.path)
    }
}

extension ClaimController {
    
    func loadDefaultClaims() {
        clearClaims()
        let claim1 = Claim(claimId: "1", title: "The Plane Crashed", summary: "", creationDate: Date(), url: "", probability: 70, aggProbability: 50, eventId: "1")
        addClaim(claim: claim1)
        let claim2 = Claim(claimId: "2", title: "High Jacked", summary: "", creationDate: Date(), url: "", probability: 45, aggProbability: 65, eventId: "1")
        addClaim(claim: claim2)
        let claim3 = Claim(claimId: "3", title: "The Plane was Stolen", summary: "", creationDate: Date(), url: "", probability: 90, aggProbability: 70, eventId: "1")
        addClaim(claim: claim3)
        save()
    }
    
}

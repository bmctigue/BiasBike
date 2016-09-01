//
//  EvidenceController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/1/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import Foundation

class EvidenceController {
    
    static let sharedInstance = EvidenceController()
    private init() {}
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("evidence")
    
    private(set) var items: [Evidence] = {
        if let items = NSKeyedUnarchiver.unarchiveObject(withFile: ArchiveURL.path) as? [Evidence] {
            return items
        } else {
            return [Evidence]()
        }
    }()
    
    func clearEvidence() {
        self.items.removeAll()
    }
    
    func addClaim(evidence: Evidence) {
        self.items.append(evidence)
    }
    
    func save() {
        let castedItems = self.items as NSArray
        NSKeyedArchiver.archiveRootObject(castedItems,toFile: EvidenceController.ArchiveURL.path)
    }
}

extension EvidenceController {
    
    func loadDefaultEvidence() {
        clearEvidence()
        let evidence1 = Evidence(evidenceId: "1", title: "The Plane Crashed", summary: "", creationDate: Date(), url: "", relevance: 45, reliability: 70, aggRR: 50)
        addClaim(evidence: evidence1)
        let evidence2 = Evidence(evidenceId: "2", title: "High Jacked", summary: "", creationDate: Date(), url: "", relevance: 35, reliability: 45, aggRR: 65)
        addClaim(evidence: evidence2)
        let evidence3 = Evidence(evidenceId: "3", title: "The Plane was Stolen", summary: "", creationDate: Date(), url: "", relevance: 85, reliability: 90, aggRR: 70)
        addClaim(evidence: evidence3)
        save()
    }
    
}

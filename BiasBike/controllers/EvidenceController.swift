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
    
    func addEvidence(evidence: Evidence) {
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
        let evidence1 = Evidence(evidenceId: "1", title: "Wing Debris", summary: "", creationDate: Date(), url: "", relevance: 45, reliability: 70, aggRR: 50)
        addEvidence(evidence: evidence1)
        let evidence2 = Evidence(evidenceId: "2", title: "Flight path", summary: "", creationDate: Date(), url: "", relevance: 35, reliability: 45, aggRR: 65)
        addEvidence(evidence: evidence2)
        save()
    }
    
}

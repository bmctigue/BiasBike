//
//  EvidenceGroupedTableViewDataSource.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EvidenceGroupedTableViewDataSource: NSObject {
    
    private(set) var evidenceHash:[String:[Evidence]] = [:]
    private(set) var claimIds: [String] = []

    init(tableView: UITableView) {
        super.init()
        tableView.dataSource = self
    }
    
    func updateDataSource(evidenceHash:[String:[Evidence]]) {
        self.evidenceHash = evidenceHash
        self.claimIds = Array(evidenceHash.keys)
    }
}

extension EvidenceGroupedTableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return claimIds.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let claimId = claimIds[section]
        let evidenceItems = evidenceHash[claimId]
        return evidenceItems!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EvidenceCell = tableView.dequeueReusableCell(withIdentifier: "EvidenceCell", for: indexPath as IndexPath) as! EvidenceCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let claimId = claimIds[section]
        let claim: Claim? = ClaimController.sharedInstance.find(key: claimId)
        if let claim = claim {
        let event = claim.event
            if let event = event {
                return "\(event.title) - \(claim.title)"
            }
            return claim.title
        }
        return ""
    }
}

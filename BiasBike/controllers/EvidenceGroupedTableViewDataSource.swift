//
//  EvidenceGroupedTableViewDataSource.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EvidenceGroupedTableViewDataSource: NSObject {
    
    private(set) var claims: [Claim] = []
    private(set) var evidenceHash:[String:[Evidence]] = [:]

    init(tableView: UITableView) {
        super.init()
        tableView.dataSource = self
    }
    
    func updateDataSource(claims: [Claim], evidenceHash:[String:[Evidence]]) {
        self.claims = claims
        self.evidenceHash = evidenceHash
    }
}

extension EvidenceGroupedTableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Array(self.evidenceHash.keys).count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let claim = claims[section]
        let evidenceItems = evidenceHash[claim.claimId]
        return evidenceItems!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EvidenceCell = tableView.dequeueReusableCell(withIdentifier: "EvidenceCell", for: indexPath as IndexPath) as! EvidenceCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let claim = claims[section]
        return claim.title
    }
}

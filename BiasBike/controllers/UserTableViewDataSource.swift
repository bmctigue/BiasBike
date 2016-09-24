//
//  UserTableViewDataSource.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class UserTableViewDataSource: NSObject {
    
    private(set) var claims: [Claim] = []
    private(set) var evidenceItems: [Evidence] = []

    init(tableView: UITableView) {
        super.init()
        tableView.dataSource = self
    }
    
    func updateDataSource(claims: [Claim], evidenceItems: [Evidence]) {
        self.claims = claims
        self.evidenceItems = evidenceItems
    }
}

extension UserTableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return claims.count
        }
        return evidenceItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:ClaimCell = tableView.dequeueReusableCell(withIdentifier: "ClaimCell", for: indexPath as IndexPath) as! ClaimCell
            return cell
        }
        let cell:EvidenceCell = tableView.dequeueReusableCell(withIdentifier: "EvidenceCell", for: indexPath as IndexPath) as! EvidenceCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Claims"
        }
        return "Evidence"
    }
}

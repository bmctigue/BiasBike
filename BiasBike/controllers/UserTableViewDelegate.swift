//
//  UserTableViewDelegate.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class UserTableViewDelegate: NSObject {

    private(set) var claims: [Claim] = []
    private(set) var evidenceItems: [Evidence] = []
    private(set) weak var userTableViewController: UserTableViewController?

    init(tableView: UITableView, userTableViewController: UserTableViewController) {
        self.userTableViewController = userTableViewController
        super.init()
        tableView.delegate = self
    }
    
    func updateDataSource(claims: [Claim], evidenceItems: [Evidence]) {
        self.claims = claims
        self.evidenceItems = evidenceItems
    }
}

extension UserTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let cell:ClaimCell = cell as! ClaimCell
            let claim = claims[indexPath.row]
            cell.updateCell(claim: claim, rating: 0, aggRating: 0)
        } else {
            let cell:EvidenceCell = cell as! EvidenceCell
            let evidence = evidenceItems[indexPath.row]
            cell.updateCell(evidence: evidence, relevance: 0, reliability: 0, aggRating: 0)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let claim = claims[indexPath.row]
            let storyboard = UIStoryboard(name: "Evidence", bundle: nil)
            let controller: EvidenceTableViewController = storyboard.instantiateViewController(withIdentifier: "EvidenceTableViewController") as! EvidenceTableViewController
            controller.claim = claim
            userTableViewController?.show(controller, sender: nil)
        } else {
            let evidence = evidenceItems[indexPath.row]
            let storyboard = UIStoryboard(name: "Evidence", bundle: nil)
            let controller: EvidenceViewController = storyboard.instantiateViewController(withIdentifier: "EvidenceViewController") as! EvidenceViewController
            controller.evidence = evidence
            userTableViewController?.show(controller, sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
}

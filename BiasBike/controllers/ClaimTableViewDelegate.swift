//
//  ClaimsTableViewDelegate.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class ClaimsTableViewDelegate: NSObject {
    
    private(set) var claims:[Claim] = []
    private(set) var claimsRatingsHash: [String:Int] = [:]
    private(set) var claimsAggRatingsHash: [String:Int] = [:]
    private(set) weak var claimsTableViewController: ClaimsTableViewController?

    init(tableView: UITableView, claimsTableViewController: ClaimsTableViewController) {
        self.claimsTableViewController = claimsTableViewController
        super.init()
        tableView.delegate = self
    }
    
    func updateDataSource(claims: [Claim], eventId: String) {
        self.claims = claims
        self.claimsRatingsHash = ClaimController.sharedInstance.claimsRatingsHash(eventId: eventId)
        self.claimsAggRatingsHash = ClaimController.sharedInstance.claimsAggRatingsHash(eventId: eventId)
    }
}

extension ClaimsTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell:ClaimCell = cell as! ClaimCell
        let claim = claims[indexPath.row]
        if let rating = claimsRatingsHash[claim.claimId], let aggRating = claimsAggRatingsHash[claim.claimId] {
            cell.updateCell(title: claim.title, rating: rating, aggRating: aggRating)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let claim = claims[indexPath.row]
        let storyboard = UIStoryboard(name: "Evidence", bundle: nil)
        let controller: EvidenceTableViewController = storyboard.instantiateViewController(withIdentifier: "EvidenceTableViewController") as! EvidenceTableViewController
        controller.claim = claim
        claimsTableViewController?.show(controller, sender: nil)
    }
}

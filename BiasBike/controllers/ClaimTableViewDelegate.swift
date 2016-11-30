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
    
    func updateDataSource(claims: [Claim], event: Event) {
        self.claims = claims
        self.claimsRatingsHash = ClaimController.sharedInstance.claimsRatingsHash(event: event)
        self.claimsAggRatingsHash = ClaimController.sharedInstance.claimsAggRatingsHash(event: event)
    }
}

extension ClaimsTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell:ClaimCell = cell as! ClaimCell
        cell.delegate = claimsTableViewController
        let claim = claims[indexPath.row]
        if let rating = claimsRatingsHash[claim.claimId], let aggRating = claimsAggRatingsHash[claim.claimId] {
            cell.updateCell(claim: claim, rating: rating, aggRating: aggRating)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let claim = claims[indexPath.row]
        let storyboard = EvidenceStoryboardFactory().create()
        let controller: EvidenceTableViewController = storyboard.instantiateViewController(withIdentifier: "EvidenceTableViewController") as! EvidenceTableViewController
        controller.claim = claim
        claimsTableViewController?.show(controller, sender: nil)
    }
}

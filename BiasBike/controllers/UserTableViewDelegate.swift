//
//  UserTableViewDelegate.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class UserTableViewDelegate: NSObject {

    private(set) var userId: String = ""
    private(set) var claims: [Claim] = []
    private(set) var evidenceItems: [Evidence] = []
    private(set) var claimsRatingsHash: [String:Int] = [:]
    private(set) var claimsAggRatingsHash: [String:Int] = [:]
    private(set) var relevanceRatingsHash: [String:Int] = [:]
    private(set) var reliabilityRatingsHash: [String:Int] = [:]
    private(set) var relevanceAggRatingsHash: [String:Int] = [:]
    private(set) var reliabilityAggRatingsHash: [String:Int] = [:]
    private(set) weak var userTableViewController: UserTableViewController?

    init(tableView: UITableView, userTableViewController: UserTableViewController) {
        self.userTableViewController = userTableViewController
        super.init()
        tableView.delegate = self
    }
    
    func updateDataSource(userId: String, claims: [Claim], evidenceItems: [Evidence],relevanceRatingsHash: [String:Int], reliabilityRatingsHash: [String:Int], relevanceAggRatingsHash: [String:Int], reliabilityAggRatingsHash: [String:Int]) {
        self.claims = claims
        self.evidenceItems = evidenceItems
        self.claimsRatingsHash = ClaimController.sharedInstance.claimsRatingsHash(userId: userId)
        self.claimsAggRatingsHash = ClaimController.sharedInstance.claimsAggRatingsHash(userId: userId)
        self.relevanceRatingsHash = relevanceRatingsHash
        self.reliabilityRatingsHash = reliabilityRatingsHash
        self.relevanceAggRatingsHash = relevanceAggRatingsHash
        self.reliabilityAggRatingsHash = reliabilityAggRatingsHash
    }
}

extension UserTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let cell:ClaimCell = cell as! ClaimCell
            cell.delegate = userTableViewController
            let claim = claims[indexPath.row]
            if let rating = claimsRatingsHash[claim.claimId], let aggRating = claimsAggRatingsHash[claim.claimId] {
                cell.updateCell(claim: claim, rating: rating, aggRating: aggRating)
            }
        } else {
            let cell:EvidenceCell = cell as! EvidenceCell
            cell.delegate = userTableViewController
            let evidence = evidenceItems[indexPath.row]
            let relevance = relevanceRatingsHash[evidence.evidenceId]!
            let reliability = reliabilityRatingsHash[evidence.evidenceId]!
            let aggRelevance = relevanceAggRatingsHash[evidence.evidenceId]!
            let aggReliability = reliabilityAggRatingsHash[evidence.evidenceId]!
            let aggRating = (aggRelevance + aggReliability)/2
            cell.updateCell(evidence: evidence, relevance: relevance, reliability: reliability, aggRating: aggRating)
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

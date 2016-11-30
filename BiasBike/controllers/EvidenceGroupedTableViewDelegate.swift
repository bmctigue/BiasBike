//
//  EvidenceGroupedTableViewDelegate.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EvidenceGroupedTableViewDelegate: NSObject {
    
    private(set) var claimIds: [String] = []
    private(set) var evidenceHash:[String:[Evidence]] = [:]
    private(set) var relevanceRatingsHash: [String:Int] = [:]
    private(set) var reliabilityRatingsHash: [String:Int] = [:]
    private(set) var relevanceAggRatingsHash: [String:Int] = [:]
    private(set) var reliabilityAggRatingsHash: [String:Int] = [:]
    private(set) weak var evidenceTableViewController: EvidenceGroupedTableViewController?

    init(tableView: UITableView, evidenceTableViewController: EvidenceGroupedTableViewController) {
        self.evidenceTableViewController = evidenceTableViewController
        super.init()
        tableView.delegate = self
    }
    
    func updateDataSource(evidenceHash: [String:[Evidence]], relevanceRatingsHash: [String:Int], reliabilityRatingsHash: [String:Int], relevanceAggRatingsHash: [String:Int], reliabilityAggRatingsHash: [String:Int]) {
        self.evidenceHash = evidenceHash
        self.relevanceRatingsHash = relevanceRatingsHash
        self.reliabilityRatingsHash = reliabilityRatingsHash
        self.relevanceAggRatingsHash = relevanceAggRatingsHash
        self.reliabilityAggRatingsHash = reliabilityAggRatingsHash
        self.claimIds = Array(evidenceHash.keys)
    }
}

extension EvidenceGroupedTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell:EvidenceCell = cell as! EvidenceCell
        cell.delegate = evidenceTableViewController
        let claimId = claimIds[indexPath.section]
        let evidenceItems = evidenceHash[claimId]
        let evidence = evidenceItems![indexPath.row]
        let relevance = relevanceRatingsHash[evidence.evidenceId]!
        let reliability = reliabilityRatingsHash[evidence.evidenceId]!
        let aggRelevance = relevanceAggRatingsHash[evidence.evidenceId]!
        let aggReliability = reliabilityAggRatingsHash[evidence.evidenceId]!
        let aggRating = (aggRelevance + aggReliability)/2
        cell.updateCell(evidence: evidence, relevance: relevance, reliability: reliability, aggRating: aggRating)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let claimId = claimIds[indexPath.section]
        let evidenceItems = evidenceHash[claimId]
        let evidence = evidenceItems![indexPath.row]
        let storyboard = EvidenceStoryboardFactory().create()
        let controller: EvidenceViewController = storyboard.instantiateViewController(withIdentifier: "EvidenceViewController") as! EvidenceViewController
        controller.evidence = evidence
        evidenceTableViewController?.show(controller, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
}

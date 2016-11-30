//
//  EvidenceTableViewDelegate.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EvidenceTableViewDelegate: NSObject {
    
    private(set) var evidence:[Evidence] = []
    private(set) var relevanceRatingsHash: [String:Int] = [:]
    private(set) var reliabilityRatingsHash: [String:Int] = [:]
    private(set) var relevanceAggRatingsHash: [String:Int] = [:]
    private(set) var reliabilityAggRatingsHash: [String:Int] = [:]
    private(set) weak var evidenceTableViewController: EvidenceTableViewController?

    init(tableView: UITableView, evidenceTableViewController: EvidenceTableViewController) {
        self.evidenceTableViewController = evidenceTableViewController
        super.init()
        tableView.delegate = self
    }
    
    func updateDataSource(evidence: [Evidence], relevanceRatingsHash: [String:Int], reliabilityRatingsHash: [String:Int], relevanceAggRatingsHash: [String:Int], reliabilityAggRatingsHash: [String:Int]) {
        self.evidence = evidence
        self.relevanceRatingsHash = relevanceRatingsHash
        self.reliabilityRatingsHash = reliabilityRatingsHash
        self.relevanceAggRatingsHash = relevanceAggRatingsHash
        self.reliabilityAggRatingsHash = reliabilityAggRatingsHash
    }
}

extension EvidenceTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell:EvidenceCell = cell as! EvidenceCell
        cell.delegate = evidenceTableViewController
        let evidenceItem = evidence[indexPath.row]
        let relevance = relevanceRatingsHash[evidenceItem.evidenceId]!
        let reliability = reliabilityRatingsHash[evidenceItem.evidenceId]!
        let aggRelevance = relevanceAggRatingsHash[evidenceItem.evidenceId]!
        let aggReliability = reliabilityAggRatingsHash[evidenceItem.evidenceId]!
        let aggRating = (aggRelevance + aggReliability)/2
        cell.updateCell(evidence: evidenceItem, relevance: relevance, reliability: reliability, aggRating: aggRating)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let evidenceItem = evidence[indexPath.row]
        let storyboard = EvidenceStoryboardFactory().create()
        let controller: EvidenceViewController = storyboard.instantiateViewController(withIdentifier: "EvidenceViewController") as! EvidenceViewController
        controller.evidence = evidenceItem
        evidenceTableViewController?.show(controller, sender: nil)
    }
}

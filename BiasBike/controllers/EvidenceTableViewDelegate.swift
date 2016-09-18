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
    private(set) weak var evidenceTableViewController: EvidenceTableViewController?

    init(tableView: UITableView, evidenceTableViewController: EvidenceTableViewController) {
        self.evidenceTableViewController = evidenceTableViewController
        super.init()
        tableView.delegate = self
    }
    
    func updateDataSource(evidence: [Evidence]) {
        self.evidence = evidence
    }
}

extension EvidenceTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell:EvidenceCell = cell as! EvidenceCell
        let evidenceItem = evidence[indexPath.row]
        cell.updateCell(title: evidenceItem.title, relevance: evidenceItem.relevance, reliability: evidenceItem.reliability, aggRR: evidenceItem.aggRR)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let evidenceItem = evidence[indexPath.row]
        let storyboard = UIStoryboard(name: "Evidence", bundle: nil)
        let controller: EvidenceViewController = storyboard.instantiateViewController(withIdentifier: "EvidenceViewController") as! EvidenceViewController
        controller.evidence = evidenceItem
        evidenceTableViewController?.show(controller, sender: nil)
    }
}

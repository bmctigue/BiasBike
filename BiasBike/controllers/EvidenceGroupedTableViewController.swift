//
//  EvidenceGroupedTableViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 7/28/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EvidenceGroupedTableViewController: UITableViewController, EvidenceCellDelegate {

    private(set) var tableViewDataSource: EvidenceGroupedTableViewDataSource?
    private(set) var tableViewDelegate: EvidenceGroupedTableViewDelegate?
    var claims: [Claim] = ClaimController.sharedInstance.all()
    var evidenceHash: [String:[Evidence]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(ClaimsTableViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)

        self.tableViewDataSource = EvidenceGroupedTableViewDataSource(tableView: tableView)
        self.tableViewDelegate = EvidenceGroupedTableViewDelegate(tableView: tableView, evidenceTableViewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }

    func handleRefresh(refreshControl: UIRefreshControl) {
        refreshData()
        refreshControl.endRefreshing()
    }
    
    func refreshData() {
        evidenceHash = EvidenceController.sharedInstance.evidenceClaimsHash()
        let relevanceHash: [String:Int] = EvidenceController.sharedInstance.evidenceRelevanceRatingsHash(claimId: nil)
        let reliabilityHash: [String:Int] = EvidenceController.sharedInstance.evidenceReliabilityRatingsHash(claimId: nil)
        let relevanceAggHash: [String:Int] = EvidenceController.sharedInstance.evidenceAggRelevanceRatingsHash(claimId: nil)
        let reliabilityAggHash: [String:Int] = EvidenceController.sharedInstance.evidenceAggReliabilityRatingsHash(claimId: nil)
        self.tableViewDataSource?.updateDataSource(claims: claims, evidenceHash: evidenceHash)
        self.tableViewDelegate?.updateDataSource(claims: claims, evidenceHash: evidenceHash, relevanceRatingsHash: relevanceHash, reliabilityRatingsHash: reliabilityHash, relevanceAggRatingsHash: relevanceAggHash, reliabilityAggRatingsHash: reliabilityAggHash)
        self.tableView.reloadData()
    }
    
    func rateButtonPressed(evidence: Evidence) {
        let storyboard = UIStoryboard(name: "Modals", bundle: nil)
        let controller: EvidenceRatingViewController = storyboard.instantiateViewController(withIdentifier: "EvidenceRatingViewController") as! EvidenceRatingViewController
        controller.evidence = evidence
        self.present(controller, animated: true, completion: nil)
    }

}

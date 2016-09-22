//
//  EvidenceTableViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 7/28/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EvidenceTableViewController: UITableViewController, EvidenceCellDelegate {

    private(set) var tableViewDataSource: EvidenceTableViewDataSource?
    private(set) var tableViewDelegate: EvidenceTableViewDelegate?
    weak var claim: Claim?
    var evidence: [Evidence] = []

    @IBOutlet weak var headerTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerTitleLabel.text = claim?.title
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(ClaimsTableViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)

        self.tableViewDataSource = EvidenceTableViewDataSource(tableView: tableView)
        self.tableViewDelegate = EvidenceTableViewDelegate(tableView: tableView, evidenceTableViewController: self)
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
        if let claim = claim {
            evidence = EvidenceController.sharedInstance.all(claimId: claim.claimId)
            let relevanceHash: [String:Int] = EvidenceController.sharedInstance.evidenceRelevanceRatingsHash(claimId: claim.claimId)
            let reliabilityHash: [String:Int] = EvidenceController.sharedInstance.evidenceReliabilityRatingsHash(claimId: claim.claimId)
            let relevanceAggHash: [String:Int] = EvidenceController.sharedInstance.evidenceAggRelevanceRatingsHash(claimId: claim.claimId)
            let reliabilityAggHash: [String:Int] = EvidenceController.sharedInstance.evidenceAggReliabilityRatingsHash(claimId: claim.claimId)
            self.tableViewDataSource?.updateDataSource(evidence: evidence)
            self.tableViewDelegate?.updateDataSource(evidence: evidence, relevanceRatingsHash: relevanceHash, reliabilityRatingsHash: reliabilityHash, relevanceAggRatingsHash: relevanceAggHash, reliabilityAggRatingsHash: reliabilityAggHash)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func rateButtonPressed(_ sender: AnyObject) {
        if let claim = claim {
            let storyboard = UIStoryboard(name: "Modals", bundle: nil)
            let controller: ClaimRatingViewController = storyboard.instantiateViewController(withIdentifier: "ClaimRatingViewController") as! ClaimRatingViewController
            controller.claim = claim
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func rateButtonPressed(evidence: Evidence) {
        let storyboard = UIStoryboard(name: "Modals", bundle: nil)
        let controller: EvidenceRatingViewController = storyboard.instantiateViewController(withIdentifier: "EvidenceRatingViewController") as! EvidenceRatingViewController
        controller.evidence = evidence
        self.present(controller, animated: true, completion: nil)
    }

}

//
//  EvidenceGroupedTableViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 7/28/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit
import RealmSwift

class EvidenceGroupedTableViewController: UITableViewController, EvidenceCellDelegate {
    
    let realm: Realm = try! Realm()
    var notificationToken: NotificationToken? = nil

    private(set) var tableViewDataSource: EvidenceGroupedTableViewDataSource?
    private(set) var tableViewDelegate: EvidenceGroupedTableViewDelegate?
    var evidenceHash: [String:[Evidence]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(EvidenceGroupedTableViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)

        self.tableViewDataSource = EvidenceGroupedTableViewDataSource(tableView: tableView)
        self.tableViewDelegate = EvidenceGroupedTableViewDelegate(tableView: tableView, evidenceTableViewController: self)
        
        notificationToken = realm.observe { notification, realm in
            self.refreshData()
        }
        
        refreshData()
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
        let items = EvidenceController.sharedInstance.itemsForHash(claim: nil)
        let relevanceHash: [String:Int] = EvidenceController.sharedInstance.evidenceRelevanceRatingsHash(items: items)
        let reliabilityHash: [String:Int] = EvidenceController.sharedInstance.evidenceReliabilityRatingsHash(items: items)
        let relevanceAggHash: [String:Int] = EvidenceController.sharedInstance.evidenceAggRelevanceRatingsHash(items: items)
        let reliabilityAggHash: [String:Int] = EvidenceController.sharedInstance.evidenceAggReliabilityRatingsHash(items: items)
        self.tableViewDataSource?.updateDataSource(evidenceHash: evidenceHash)
        self.tableViewDelegate?.updateDataSource(evidenceHash: evidenceHash, relevanceRatingsHash: relevanceHash, reliabilityRatingsHash: reliabilityHash, relevanceAggRatingsHash: relevanceAggHash, reliabilityAggRatingsHash: reliabilityAggHash)
        self.tableView.reloadData()
    }
    
    func rateButtonPressed(evidence: Evidence) {
        let storyboard = StoryboardFactory().create(name: "Modals")
        let controller: EvidenceRatingViewController = storyboard.instantiateViewController(withIdentifier: "EvidenceRatingViewController") as! EvidenceRatingViewController
        controller.evidence = evidence
        self.present(controller, animated: true, completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        notificationToken?.invalidate()
    }

}

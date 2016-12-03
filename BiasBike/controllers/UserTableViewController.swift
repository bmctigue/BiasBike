//
//  UserTableViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 7/28/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit
import RealmSwift

class UserTableViewController: UITableViewController, ClaimCellDelegate, EvidenceCellDelegate {
    
    let realm: Realm = try! Realm()
    var notificationToken: NotificationToken? = nil

    private(set) var tableViewDataSource: UserTableViewDataSource?
    private(set) var tableViewDelegate: UserTableViewDelegate?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let firstName = user?.firstName, let lastName = user?.lastName {
            self.title = "\(firstName) \(lastName)"
        }
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(UserTableViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)

        self.tableViewDataSource = UserTableViewDataSource(tableView: tableView)
        self.tableViewDelegate = UserTableViewDelegate(tableView: tableView, userTableViewController: self)
        
        notificationToken = realm.addNotificationBlock { notification, realm in
            self.refreshData()
        }
        
        refreshData()
    }

    func handleRefresh(refreshControl: UIRefreshControl) {
        refreshData()
        refreshControl.endRefreshing()
    }
    
    func refreshData() {
        let claims = ClaimController.sharedInstance.all(userId: (user?.userId)!)
        let evidenceItems = EvidenceController.sharedInstance.all(userId: (user?.userId)!)
        let items = EvidenceController.sharedInstance.itemsForHash(claim: nil)
        let relevanceHash: [String:Int] = EvidenceController.sharedInstance.evidenceRelevanceRatingsHash(items: items)
        let reliabilityHash: [String:Int] = EvidenceController.sharedInstance.evidenceReliabilityRatingsHash(items: items)
        let relevanceAggHash: [String:Int] = EvidenceController.sharedInstance.evidenceAggRelevanceRatingsHash(items: items)
        let reliabilityAggHash: [String:Int] = EvidenceController.sharedInstance.evidenceAggReliabilityRatingsHash(items: items)
        self.tableViewDataSource?.updateDataSource(claims: claims, evidenceItems: evidenceItems)
        self.tableViewDelegate?.updateDataSource(userId: (user?.userId)!, claims: claims, evidenceItems: evidenceItems, relevanceRatingsHash: relevanceHash, reliabilityRatingsHash: reliabilityHash, relevanceAggRatingsHash: relevanceAggHash, reliabilityAggRatingsHash: reliabilityAggHash)
        self.tableView.reloadData()
    }
    
    func rateButtonPressed(claim: Claim) {
        let storyboard = StoryboardFactory().create(name: "Modals")
        let controller: ClaimRatingViewController = storyboard.instantiateViewController(withIdentifier: "ClaimRatingViewController") as! ClaimRatingViewController
        controller.claim = claim
        self.present(controller, animated: true, completion: nil)
    }
    
    func rateButtonPressed(evidence: Evidence) {
        let storyboard = StoryboardFactory().create(name: "Modals")
        let controller: EvidenceRatingViewController = storyboard.instantiateViewController(withIdentifier: "EvidenceRatingViewController") as! EvidenceRatingViewController
        controller.evidence = evidence
        self.present(controller, animated: true, completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        notificationToken?.stop()
    }

}

//
//  UserTableViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 7/28/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController, ClaimCellDelegate {

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
        let claims = ClaimController.sharedInstance.all(userId: (user?.userId)!)
        let evidenceItems = EvidenceController.sharedInstance.all(userId: (user?.userId)!)
        
        self.tableViewDataSource?.updateDataSource(claims: claims, evidenceItems: evidenceItems)
        self.tableViewDelegate?.updateDataSource(userId: (user?.userId)!, claims: claims, evidenceItems: evidenceItems)
        self.tableView.reloadData()
    }
    
    func rateButtonPressed(claim: Claim) {
        let storyboard = UIStoryboard(name: "Modals", bundle: nil)
        let controller: ClaimRatingViewController = storyboard.instantiateViewController(withIdentifier: "ClaimRatingViewController") as! ClaimRatingViewController
        controller.claim = claim
        self.present(controller, animated: true, completion: nil)
    }

}

//
//  ClaimsTableViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 7/28/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit
import RealmSwift

class ClaimsTableViewController: UITableViewController, ClaimCellDelegate {
    
    let realm: Realm = try! Realm()
    var notificationToken: NotificationToken? = nil

    private(set) var tableViewDataSource: ClaimsTableViewDataSource?
    private(set) var tableViewDelegate: ClaimsTableViewDelegate?
    var eventId: String = ""
    var eventTitle: String = ""
    var claims: [Claim] = []

    @IBOutlet weak var headerTitleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        self.headerTitleLabel.text = eventTitle

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(ClaimsTableViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)

        self.tableViewDataSource = ClaimsTableViewDataSource(tableView: tableView)
        self.tableViewDelegate = ClaimsTableViewDelegate(tableView: tableView, claimsTableViewController: self)
        
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
        self.claims = ClaimController.sharedInstance.all(eventId: eventId)
        self.tableViewDataSource?.updateDataSource(claims: claims)
        self.tableViewDelegate?.updateDataSource(claims: claims, eventId: eventId)
        self.tableView.reloadData()
    }
    
    func rateButtonPressed(claim: Claim) {
        let storyboard = UIStoryboard(name: "Modals", bundle: nil)
        let controller: ClaimRatingViewController = storyboard.instantiateViewController(withIdentifier: "ClaimRatingViewController") as! ClaimRatingViewController
        controller.claim = claim
        self.present(controller, animated: true, completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        notificationToken?.stop()
    }

}

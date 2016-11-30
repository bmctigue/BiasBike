//
//  EventTableViewController.swift
//  Interview
//
//  Created by Bruce McTigue on 7/28/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit
import RealmSwift

class EventTableViewController: UITableViewController, CategoriesTableViewControllerDelegate {
    
    let realm: Realm = try! Realm()
    var notificationToken: NotificationToken? = nil

    @IBOutlet weak var titleLabel: UILabel!

    private(set) var tableViewDataSource: EventTableViewDataSource?
    private(set) var tableViewDelegate: EventTableViewDelegate?
    private(set) var categoryHash:[String:[Event]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Events"
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        ThemeAppearance().setNavigationBarAppearance(navigationBar: self.navigationController?.navigationBar)

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(EventTableViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 300

        self.tableViewDataSource = EventTableViewDataSource(tableView: tableView)
        self.tableViewDelegate = EventTableViewDelegate(tableView: tableView, eventTableViewController: self)
        
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
        self.categoryHash = EventController.sharedInstance.categoryHash()
        self.tableViewDataSource?.updateDataSource(categoryHash: categoryHash)
        self.tableViewDelegate?.updateDataSource(categoryHash: categoryHash)
        self.tableView.reloadData()
    }
    
    @IBAction func categoriesEditButtonPressed(_ sender: AnyObject) {
        let storyboard = ModalsStoryboardFactory().create()
        let controller: CategoriesTableViewController = storyboard.instantiateViewController(withIdentifier: "CategoriesTableViewController") as! CategoriesTableViewController
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func refreshButtonPressed(_ sender: AnyObject) {
        ModelControllerUtilities().refreshAppData()
        refreshData()
        let alertController = UIAlertController(title: "Data Reset", message:"The app data has been reset", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func doneButtonPressed() {
        refreshData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        notificationToken?.stop()
    }
}

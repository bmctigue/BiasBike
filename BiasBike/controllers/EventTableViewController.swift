//
//  EventTableViewController.swift
//  Interview
//
//  Created by Bruce McTigue on 7/28/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {

    @IBOutlet weak var titleLabel: UILabel!

    private(set) var tableViewDataSource: EventTableViewDataSource?
    private(set) var tableViewDelegate: EventTableViewDelegate?
    private(set) var categoryHash:[String:[Event]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Events"
        
        ThemeAppearance().setNavigationBarAppearance(navigationBar: self.navigationController?.navigationBar)

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(EventTableViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 300

        self.tableViewDataSource = EventTableViewDataSource(tableView: tableView)
        self.tableViewDelegate = EventTableViewDelegate(tableView: tableView, eventTableViewController: self)
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
        self.categoryHash = EventController.sharedInstance.categoryHash()
        self.tableViewDataSource?.updateDataSource(categoryHash: categoryHash)
        self.tableViewDelegate?.updateDataSource(categoryHash: categoryHash)
        self.tableView.reloadData()
    }
    
    @IBAction func categoriesEditButtonPressed(_ sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Modals", bundle: nil)
        let controller: CategoriesTableViewController = storyboard.instantiateViewController(withIdentifier: "CategoriesTableViewController") as! CategoriesTableViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func refreshButtonPressed(_ sender: AnyObject) {
        ModelControllerUtilities().refreshAppData()
        refreshData()
        let alertController = UIAlertController(title: "Data Reset", message:"The app data has been reset", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

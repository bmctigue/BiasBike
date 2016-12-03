//
//  UsersTableViewDelegate.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class UsersTableViewDelegate: NSObject {
    
    private(set) var users:[User] = []
    private(set) var userRatingsHash: [String:Int] = [:]
    private(set) var userAggRatingsHash: [String:Int] = [:]
    private(set) weak var usersTableViewController: UsersTableViewController?

    init(tableView: UITableView, usersTableViewController: UsersTableViewController) {
        self.usersTableViewController = usersTableViewController
        super.init()
        tableView.delegate = self
    }
    
    func updateDataSource(users: [User]) {
        self.users = users
        self.userRatingsHash = UserController.sharedInstance.userRatingsHash()
        self.userAggRatingsHash = UserController.sharedInstance.userAggRatingsHash()
    }
}

extension UsersTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell:UserCell = cell as! UserCell
        let user = users[indexPath.row]
        if let rating = userAggRatingsHash[user.userId] {
            cell.updateCell(firstName: user.firstName, lastName: user.lastName, rating: rating, url: user.url)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let storyboard = StoryboardFactory().create(name: "Main")
        let controller: UserTableViewController = storyboard.instantiateViewController(withIdentifier: "UserTableViewController") as! UserTableViewController
        controller.user = user
        usersTableViewController?.show(controller, sender: nil)
    }
}

//
//  UsersTableViewDataSource.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class UsersTableViewDataSource: NSObject {
    
    private(set) var users:[User] = []

    init(tableView: UITableView) {
        super.init()
        tableView.dataSource = self
    }
    
    func updateDataSource(users: [User]) {
        self.users = users
    }
}

extension UsersTableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UserCell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath as IndexPath) as! UserCell
        return cell
    }
}

//
//  EventTableViewDataSource.swift
//  Interview
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EventTableViewDataSource: NSObject {
    
    var categoryHash:[String:[Event]] = [:]

    init(tableView: UITableView) {
        super.init()
        tableView.dataSource = self
    }
    
    func updateDataSource(categoryHash: [String:[Event]]) {
        self.categoryHash = categoryHash
    }
}

extension EventTableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let hash = EventController.sharedInstance.categoryHash()
        return Array(hash.keys).count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = CategoryController.sharedInstance.categoryFromSortedCategories(section: section, categoryHash:categoryHash)
        if let events = self.categoryHash[category.rawValue] {
            return Array(events).count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EventCell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath as IndexPath) as! EventCell
        return cell
    }
}

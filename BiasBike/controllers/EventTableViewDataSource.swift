//
//  EventTableViewDataSource.swift
//  Interview
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EventTableViewDataSource: NSObject {

    init(tableView: UITableView) {
        super.init()
        tableView.dataSource = self
    }
}

extension EventTableViewDataSource: UITableViewDataSource {

    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventController.sharedInstance.all().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EventCell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath as IndexPath) as! EventCell
        return cell
    }

}

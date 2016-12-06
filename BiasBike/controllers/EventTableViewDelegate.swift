//
//  EventTableViewDelegate.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EventTableViewDelegate: EventTableViewDelegateCommon {
    
}

extension EventTableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell:EventHeaderCell = tableView.dequeueReusableCell(withIdentifier: "EventHeaderCell") as! EventHeaderCell
        let category = sortedCategories[section]
        cell.delegate = self
        cell.update(category: category)
        return cell
    }
}

extension EventTableViewDelegate: EventHeaderCellDelegate {
    
    func headerButtonPressed(category: Category) {
        let storyboard = StoryboardFactory().create(name: "Main")
        let controller: CategoryTableViewController = storyboard.instantiateViewController(withIdentifier: "CategoryTableViewController") as! CategoryTableViewController
        controller.category = category
        tableViewController?.show(controller, sender: nil)
    }
}

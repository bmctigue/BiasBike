//
//  CategoryTableViewDelegate.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class CategoryTableViewDelegate: EventTableViewDelegateCommon {}

extension CategoryTableViewDelegate {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell:EventCell = cell as! EventCell
        self.updateCell(cell: cell, category: category, indexPath: indexPath)
    }
}

//
//  CategoryTableViewDelegate.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class FallaciesTableViewDelegate: NSObject {
    
    weak var evidence: Evidence?
    private(set) var fallacies:[Fallacy] = []
    var selectedFallacies:[Fallacy] = []
    
    init(tableView: UITableView, evidence: Evidence?) {
        self.fallacies = FallacyController.sharedInstance.all()
        self.evidence = evidence
        super.init()
        tableView.delegate = self
    }
    
    func saveSelectedFallacies() {
        EvidenceController.sharedInstance.update(item: evidence!)
    }
}

extension FallaciesTableViewDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let fallacy = fallacies[indexPath.row]
        cell.textLabel?.text = fallacy.title
        if selectedFallacies.contains(fallacy) {
            cell.accessoryType = .checkmark
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.bottom)
        } else {
            cell.accessoryType = .none
        }
        cell.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        let fallacy = fallacies[indexPath.row]
        if !(evidence!.fallacies.contains(fallacy)) {
            evidence!.fallacies.append(fallacy)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        let fallacy = fallacies[indexPath.row]
        if (evidence!.fallacies.contains(fallacy)) {
            let index: Int = (evidence!.fallacies.index(of: fallacy)!)
            evidence!.fallacies.remove(objectAtIndex: index)
        }
    }
}

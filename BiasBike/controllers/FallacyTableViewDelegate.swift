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
        if let evidence = evidence {
            self.selectedFallacies = Array(evidence.fallacies)
        }
        super.init()
        tableView.delegate = self
    }
    
    func saveSelectedFallacies() {
        if let evidence = evidence {
            EvidenceController.sharedInstance.updateFallacies(item: evidence, fallacies: selectedFallacies)
        }
    }
}

extension FallaciesTableViewDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let fallacy = fallacies[indexPath.row]
        let cell:FallacyCell = cell as! FallacyCell
        let checked = selectedFallacies.contains(fallacy)
        let title = fallacy.title
        let icon = fallacy.icon
        cell.updateCell(title: title, icon: icon, checked:checked)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:FallacyCell = tableView.cellForRow(at: indexPath) as! FallacyCell
        let fallacy = fallacies[indexPath.row]
        updateFallacies(fallacy: fallacy, cell: cell)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell:FallacyCell = tableView.cellForRow(at: indexPath) as! FallacyCell
        let fallacy = fallacies[indexPath.row]
        updateFallacies(fallacy: fallacy, cell: cell)
    }
    
    func updateFallacies(fallacy: Fallacy, cell: FallacyCell) {
        if (selectedFallacies.contains(fallacy)) {
            let index: Int = (selectedFallacies.index(of: fallacy)!)
            selectedFallacies.remove(at: index)
            cell.accessoryType = .none
        } else {
            selectedFallacies.append(fallacy)
            cell.accessoryType = .checkmark
        }
    }
    
}

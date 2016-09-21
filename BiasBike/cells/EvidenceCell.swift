//
//  EvidenceCell.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/15/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EvidenceCell: UITableViewCell {
    
    func updateCell(title: String, relevance: Int, reliability: Int) {
        self.textLabel?.text = title
        self.detailTextLabel?.text = "Relevance: \(relevance) and Reliability: \(reliability)"
        let ratingImageName = CellUtitilities().ratingImageNameString(rating: (relevance + reliability)/2)
        self.imageView?.image = UIImage(named: ratingImageName)
    }
}

//
//  EvidenceCell.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/15/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EvidenceCell: UITableViewCell {
    
    @IBOutlet weak var aggRatingLabel: UILabel!
    
    func updateCell(title: String, relevance: Int, reliability: Int, aggRelevance: Int, aggReliability: Int) {
        self.textLabel?.text = title
        self.detailTextLabel?.text = "Relevance: \(relevance) and Reliability: \(reliability)"
        let aggRating = (aggRelevance + aggReliability)/2
        let ratingImageName = CellUtitilities().ratingImageNameString(rating: aggRating)
        self.aggRatingLabel.text = "\(aggRating)"
        self.imageView?.image = UIImage(named: ratingImageName)
    }
}

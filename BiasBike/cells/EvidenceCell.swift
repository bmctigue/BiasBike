//
//  EvidenceCell.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/15/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

protocol EvidenceCellDelegate: class {
    func rateButtonPressed(evidence: Evidence)
}

class EvidenceCell: UITableViewCell {
    
    @IBOutlet weak var aggRatingLabel: UILabel!
    
    weak var delegate: EvidenceCellDelegate?
    var evidence: Evidence?
    
    func updateCell(evidence: Evidence, relevance: Int, reliability: Int, aggRelevance: Int, aggReliability: Int) {
        self.evidence = evidence
        self.textLabel?.text = evidence.title
        self.detailTextLabel?.text = "Relevance: \(relevance) and Reliability: \(reliability)"
        let aggRating = (aggRelevance + aggReliability)/2
        let ratingImageName = CellUtitilities().ratingImageNameString(rating: aggRating)
        self.aggRatingLabel.text = "\(aggRating)"
        self.imageView?.image = UIImage(named: ratingImageName)
    }
    
    @IBAction func rateButtonPressed(_ sender: AnyObject) {
        delegate?.rateButtonPressed(evidence: evidence!)
    }
}

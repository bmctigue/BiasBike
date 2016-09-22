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
    
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var aggRatingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    weak var delegate: EvidenceCellDelegate?
    var evidence: Evidence?
    
    func updateCell(evidence: Evidence, relevance: Int, reliability: Int, aggRating: Int) {
        self.evidence = evidence
        self.titleLabel?.text = evidence.title
        self.subTitleLabel?.text = "Relevance: \(relevance) and Reliability: \(reliability)"
        let ratingImageName = CellUtitilities().ratingImageNameString(rating: aggRating)
        self.aggRatingLabel.text = "\(aggRating)"
        self.ratingImageView?.image = UIImage(named: ratingImageName)
    }
    
    @IBAction func rateButtonPressed(_ sender: AnyObject) {
        delegate?.rateButtonPressed(evidence: evidence!)
    }
}

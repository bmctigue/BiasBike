//
//  EvidenceCell.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/15/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EvidenceCell: UITableViewCell {
    
    func updateCell(title: String, relevance: Int, reliability: Int, aggRR: Int) {
        self.textLabel?.text = title
        self.detailTextLabel?.text = "Relevance: \(relevance) and Reliability: \(reliability)"
        let ratingImageName = ratingImageNameString(aggRR: aggRR)
        self.imageView?.image = UIImage(named: ratingImageName)
    }
    
    func ratingImageNameString(aggRR: Int) -> String {
        var ratingImageName: String
        if aggRR <= 25 {
            ratingImageName = "red_10_percent"
        } else if aggRR <= 50 {
            ratingImageName = "orange_40_percent"
        } else if aggRR <= 75 {
            ratingImageName = "yellow_70_percent"
        } else {
            ratingImageName = "green_90_percent"
        }
        return ratingImageName
    }
}
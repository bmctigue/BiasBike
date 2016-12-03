//
//  EventCell.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/11/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var fallacyContainerView: UIView!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var aggRatingLabel: UILabel!
    
    var fallacyView: UIView?
    var aggRating: Int = 0

    func updateCell(title: String, photoUrl: String, aggRating: Int, fallacyView: UIView?) {
        titleLabel.text = title
        eventImage.image = UIImage(named: photoUrl)
        self.fallacyView = fallacyView
        self.aggRating = aggRating
    }
    
    override func layoutSubviews() {
        for currentFallacyView in fallacyContainerView.subviews {
            currentFallacyView.removeFromSuperview()
        }
        if let fallacyView = fallacyView {
            fallacyView.frame = fallacyContainerView.bounds
            fallacyContainerView.addSubview(fallacyView)
        }
        let ratingImageName = CellUtitilities().ratingImageNameString(rating: aggRating)
        self.aggRatingLabel.text = "\(aggRating)"
        self.ratingImageView?.image = UIImage(named: ratingImageName)
    }
}

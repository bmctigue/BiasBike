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
    
    var fallacyCollectionViewController: FallacyCollectionViewController? = nil
    var aggRating: Int = 0
    
    override func awakeFromNib() {
        let storyboard = StoryboardFactory().create(name: "Fallacy")
        fallacyCollectionViewController = (storyboard.instantiateViewController(withIdentifier: "FallacyCollectionViewController") as? FallacyCollectionViewController)!
        fallacyCollectionViewController?.view.frame = fallacyContainerView.bounds
        fallacyContainerView.addSubview((fallacyCollectionViewController?.view)!)
    }

    func updateCell(title: String, photoUrl: String, aggRating: Int, fallacies: [Fallacy]) {
        titleLabel.text = title
        eventImage.image = UIImage(named: photoUrl)
        self.aggRating = aggRating
        let ratingImageName = CellUtitilities().ratingImageNameString(rating: aggRating)
        aggRatingLabel.text = "\(aggRating)"
        ratingImageView?.image = UIImage(named: ratingImageName)
        fallacyCollectionViewController?.fallacies = fallacies
        fallacyCollectionViewController?.updateFallacies()
    }
}

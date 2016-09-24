//
//  UserCell.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/24/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var aggRatingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    func updateCell(firstName: String, lastName: String, rating: Int, url: String) {
        self.titleLabel?.text = "\(firstName) \(lastName)"
        self.subTitleLabel?.text = "Rating: \(rating)"
        self.ratingImageView?.image = UIImage(named: url)
    }

}

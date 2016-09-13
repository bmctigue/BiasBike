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

    func updateCell(title: String, photoUrl: String) {
        titleLabel.text = title
        eventImage.image = UIImage(named: photoUrl)
    }

}

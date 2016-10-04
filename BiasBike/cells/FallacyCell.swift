//
//  UserCell.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/24/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class FallacyCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func updateCell(title: String, icon: String, checked: Bool) {
        self.titleLabel?.text = "\(title)"
        self.iconImageView?.image = UIImage(named: icon)
        self.selectionStyle = .none
        self.accessoryType = checked ? .checkmark : .none
    }

}

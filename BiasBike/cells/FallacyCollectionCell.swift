//
//  FallacyCollectionCell.swift
//  BiasBike
//
//  Created by Bruce McTigue on 10/4/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class FallacyCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    func updateCell(icon: String) {
        self.iconImageView?.image = UIImage(named: icon)
    }

}

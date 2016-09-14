//
//  EventHeaderCell.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/11/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

protocol EventHeaderCellDelegate: class {
    func headerButtonPressed(categoryType: CategoryType)
}

class EventHeaderCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nextImageView: UIImageView!
    @IBOutlet weak var nextCircleView: UIView!
    
    var categoryType: CategoryType = .World
    
    override func awakeFromNib() {
        let nextImage = self.nextImageView.image?.withRenderingMode(.alwaysTemplate)
        self.nextImageView.image = nextImage
        self.nextCircleView.layer.cornerRadius = 12.0
        self.nextCircleView.layer.borderWidth = 1.0
    }
    
    func update(type: CategoryType) {
        self.categoryType = type
        let category = CategoryFactory().create(type: type)
        let color = category.color
        self.titleLabel.text = type.rawValue
        self.titleLabel.textColor = color
        self.nextImageView.tintColor = color
        self.nextCircleView.layer.borderColor = color.cgColor
    }
    
}
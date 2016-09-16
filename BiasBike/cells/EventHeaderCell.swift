//
//  EventHeaderCell.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/11/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

protocol EventHeaderCellDelegate: class {
    func headerButtonPressed(category: Category)
}

class EventHeaderCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nextImageView: UIImageView!
    @IBOutlet weak var nextCircleView: UIView!
    weak var delegate: EventHeaderCellDelegate?
    
    var category: Category = .World
    
    override func awakeFromNib() {
        let nextImage = self.nextImageView.image?.withRenderingMode(.alwaysTemplate)
        self.nextImageView.image = nextImage
        self.nextCircleView.layer.cornerRadius = 12.0
        self.nextCircleView.layer.borderWidth = 1.0
    }
    
    func update(category: Category) {
        self.category = category
        self.titleLabel.text = category.rawValue
        self.titleLabel.textColor = category.color
        self.nextImageView.tintColor = category.color
        self.nextCircleView.layer.borderColor = category.color.cgColor
    }
    
    @IBAction func headerButtonPressed(sender: AnyObject) {
        delegate?.headerButtonPressed(category: category)
    }
    
}

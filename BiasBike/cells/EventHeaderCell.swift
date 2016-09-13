//
//  EventHeaderCell.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/11/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EventHeaderCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nextImageView: UIImageView!
    @IBOutlet weak var nextCircleView: UIView!
    
    override func awakeFromNib() {
        let nextImage = self.nextImageView.image?.withRenderingMode(.alwaysTemplate)
        self.nextImageView.image = nextImage
        self.nextCircleView.layer.cornerRadius = 12.0
        self.nextCircleView.layer.borderWidth = 1.0
    }
    
    func update(category: String) {
        var color: UIColor
        color = headerInfo(category: category)
        self.titleLabel.text = category
        self.titleLabel.textColor = color
        self.nextImageView.tintColor = color
        self.nextCircleView.layer.borderColor = color.cgColor
    }
    
    func headerInfo(category: String) -> UIColor {
        var color: UIColor
        switch category {
        case Category.World.rawValue:
            color = .magenta
        case Category.News.rawValue:
            color = .blue
        case Category.Politics.rawValue:
            color = .orange
        case Category.Myths.rawValue:
            color = .cyan
        case Category.Religion.rawValue:
            color = .red
        case Category.Health.rawValue:
            color = .green
        case Category.Science.rawValue:
            color = .yellow
        default:
            return .black
        }
        return color
    }
}

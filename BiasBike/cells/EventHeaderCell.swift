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
    
    func update(section: Int) {
        var title: String
        var color: UIColor
        (title,color) = headerInfo(section: section)
        self.titleLabel.text = title
        self.titleLabel.textColor = color
        self.nextImageView.tintColor = color
        self.nextCircleView.layer.borderColor = color.cgColor
    }
    
    func headerInfo(section: Int) -> (String,UIColor) {
        var text: String
        var color: UIColor
        switch section {
        case 0:
            text = Category.World.rawValue
            color = .magenta
        case 1:
            text = Category.News.rawValue
            color = .blue
        case 2:
            text = Category.Politics.rawValue
            color = .orange
        case 3:
            text = Category.Myths.rawValue
            color = .cyan
        case 4:
            text = Category.Religion.rawValue
            color = .red
        case 5:
            text = Category.Health.rawValue
            color = .green
        case 6:
            text = Category.Science.rawValue
            color = .yellow
        default:
            text = Category.World.rawValue
            color = .black
        }
        return (text,color)
    }
}

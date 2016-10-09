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
    var fallacyView: UIView!

    func updateCell(title: String, photoUrl: String, fallacyView: UIView?) {
        titleLabel.text = title
        eventImage.image = UIImage(named: photoUrl)
        self.fallacyView = fallacyView
        
    }
    
    override func layoutSubviews() {
        for currentFallacyView in fallacyContainerView.subviews {
            currentFallacyView.removeFromSuperview()
        }
        if let fallacyView = fallacyView {
            fallacyView.frame = fallacyContainerView.bounds
            fallacyContainerView.addSubview(fallacyView)
        }
    }

}

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

    func updateCell(title: String, photoUrl: String, evidence: Evidence?) {
        titleLabel.text = title
        eventImage.image = UIImage(named: photoUrl)
        
        if let evidence = evidence {
            let storyboard = UIStoryboard(name: "Fallacy", bundle: nil)
            let fallacyCollectionViewController = storyboard.instantiateViewController(withIdentifier: "FallacyCollectionViewController") as? FallacyCollectionViewController
            if let fallacyCollectionViewController = fallacyCollectionViewController {
                fallacyCollectionViewController.evidence = evidence
                fallacyCollectionViewController.view.frame = fallacyContainerView.bounds
                fallacyContainerView.addSubview(fallacyCollectionViewController.view)
                fallacyContainerView.sendSubview(toBack: fallacyCollectionViewController.view)
            }
        }
    }

}

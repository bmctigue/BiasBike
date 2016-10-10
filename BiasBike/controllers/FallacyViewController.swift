//
//  FallacyViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 10/6/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class FallacyViewController: UIViewController {
    
    @IBOutlet weak var fallacyNavigationItem: UINavigationItem!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    
    var fallacy: Fallacy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let fallacy = fallacy {
            fallacyNavigationItem.title = fallacy.title
            summaryLabel.text = fallacy.summary
            exampleLabel.text = fallacy.example
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

}

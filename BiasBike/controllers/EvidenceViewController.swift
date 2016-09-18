//
//  EvidenceViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/18/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EvidenceViewController: UIViewController {
    
    weak var evidence: Evidence?
    
    @IBOutlet weak var evidenceLabel: UILabel!
    @IBOutlet weak var evidenceImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.evidenceLabel.text = evidence?.title
        self.evidenceImageView?.image = UIImage(named: (evidence?.url)!)
        
    }

    @IBAction func rateButtonPressed(_ sender: AnyObject) {
//        if let evidence = evidence {
//            let storyboard = UIStoryboard(name: "Modals", bundle: nil)
//            let controller: EvidenceRatingViewController = storyboard.instantiateViewController(withIdentifier: "EvidenceRatingViewController") as! EvidenceRatingViewController
//            controller.claim = claim
//            self.present(controller, animated: true, completion: nil)
//        }
    }
    
}

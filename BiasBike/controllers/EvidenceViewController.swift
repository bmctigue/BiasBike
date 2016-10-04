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
    
    @IBOutlet weak var relevanceRatingImageView: UIImageView!
    @IBOutlet weak var reliabilityRatingImageView: UIImageView!
    @IBOutlet weak var relevanceRatingLabel: UILabel!
    @IBOutlet weak var reliabilityRatingLabel: UILabel!
    @IBOutlet weak var evidenceImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = evidence?.title
        self.evidenceImageView?.image = UIImage(named: (evidence?.url)!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let relevanceRatings = RelevanceRatingController.sharedInstance.all(modelId: (evidence?.evidenceId)!)
        let relevanceRating = RatingController.sharedInstance.averageRating(ratings: relevanceRatings)
        let reliabilityRatings = ReliabilityRatingController.sharedInstance.all(modelId: (evidence?.evidenceId)!)
        let reliabilityRating = RatingController.sharedInstance.averageRating(ratings: reliabilityRatings)
        relevanceRatingLabel.text = "\(relevanceRating)"
        reliabilityRatingLabel.text = "\(reliabilityRating)"
        relevanceRatingImageView.image = UIImage(named:CellUtitilities().ratingImageNameString(rating: relevanceRating))
        reliabilityRatingImageView.image = UIImage(named:CellUtitilities().ratingImageNameString(rating: reliabilityRating))
    }

    @IBAction func rateButtonPressed(_ sender: AnyObject) {
        if let evidence = evidence {
            let storyboard = UIStoryboard(name: "Modals", bundle: nil)
            let controller: EvidenceRatingViewController = storyboard.instantiateViewController(withIdentifier: "EvidenceRatingViewController") as! EvidenceRatingViewController
            controller.evidence = evidence
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func fallacyButtonPressed(_ sender: AnyObject) {
        if let evidence = evidence {
            let storyboard = UIStoryboard(name: "Modals", bundle: nil)
            let controller: FallaciesTableViewController = storyboard.instantiateViewController(withIdentifier: "FallaciesTableViewController") as! FallaciesTableViewController
            controller.evidence = evidence
            self.present(controller, animated: true, completion: nil)
        }
    }
}

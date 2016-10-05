//
//  EvidenceViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/18/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit
import RealmSwift

class EvidenceViewController: UIViewController {
    
    let realm: Realm = try! Realm()
    var notificationToken: NotificationToken? = nil
    
    weak var evidence: Evidence?
    
    @IBOutlet weak var relevanceRatingImageView: UIImageView!
    @IBOutlet weak var reliabilityRatingImageView: UIImageView!
    @IBOutlet weak var relevanceRatingLabel: UILabel!
    @IBOutlet weak var reliabilityRatingLabel: UILabel!
    @IBOutlet weak var evidenceImageView: UIImageView!
    @IBOutlet weak var fallacyContainerView: UIView!
    @IBOutlet weak var tapToAddFallaciesLabel: UILabel!
    
    var fallacyCollectionViewController: FallacyCollectionViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = evidence?.title
        self.evidenceImageView?.image = UIImage(named: (evidence?.url)!)
        
        if let evidence = evidence {
            let storyboard = UIStoryboard(name: "Fallacy", bundle: nil)
            fallacyCollectionViewController = storyboard.instantiateViewController(withIdentifier: "FallacyCollectionViewController") as? FallacyCollectionViewController
            if let fallacyCollectionViewController = fallacyCollectionViewController {
                fallacyCollectionViewController.evidence = evidence
                fallacyCollectionViewController.view.frame = fallacyContainerView.bounds
                fallacyContainerView.addSubview(fallacyCollectionViewController.view)
                fallacyContainerView.sendSubview(toBack: fallacyCollectionViewController.view)
            }
        }
        
        updateTapToAddLabel()
        
        notificationToken = realm.addNotificationBlock { notification, realm in
            self.updateTapToAddLabel()
            self.fallacyCollectionViewController?.collectionViewDataSource?.updateData()
            self.fallacyCollectionViewController?.collectionView?.reloadData()
        }
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
    
    func updateTapToAddLabel() {
        self.tapToAddFallaciesLabel.isHidden = evidence?.fallacies.count == 0 ? false : true
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
            let storyboard = UIStoryboard(name: "Fallacy", bundle: nil)
            let controller: FallaciesTableViewController = storyboard.instantiateViewController(withIdentifier: "FallaciesTableViewController") as! FallaciesTableViewController
            controller.evidence = evidence
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        notificationToken?.stop()
    }

}

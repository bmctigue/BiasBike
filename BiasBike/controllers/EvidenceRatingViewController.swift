//
//  EvidenceRatingViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/16/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EvidenceRatingViewController: UIViewController {
    
    weak var evidence: Evidence?
    var relevance: Int = 0
    var reliability: Int = 0
    
    @IBOutlet weak var customNavigationItem: UINavigationItem!
    
    @IBOutlet weak var relevanceSlider: UISlider!
    @IBOutlet weak var reliabilitySlider: UISlider!
    @IBOutlet weak var relevanceCircularProgress: KDCircularProgress!
    @IBOutlet weak var reliabilityCircularProgress: KDCircularProgress!
    @IBOutlet weak var relevanceLabel: UILabel!
    @IBOutlet weak var reliabilityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let evidence = evidence {
            customNavigationItem.title = "\(evidence.title)"
        } else {
            customNavigationItem.title = "Evidence"
        }
        let relevanceRatings = RelevanceRatingController.sharedInstance.all(modelId: (evidence?.evidenceId)!)
        self.relevance = RatingController.sharedInstance.latestRating(ratings: relevanceRatings)
        setUpProgressView(circularProgress: relevanceCircularProgress, slider: relevanceSlider, rating: relevance)
        let reliabilityRatings = ReliabilityRatingController.sharedInstance.all(modelId: (evidence?.evidenceId)!)
        self.reliability = RatingController.sharedInstance.latestRating(ratings: reliabilityRatings)
        setUpProgressView(circularProgress: reliabilityCircularProgress, slider: reliabilitySlider, rating: reliability)
    }
    
    func setUpProgressView(circularProgress: KDCircularProgress, slider: UISlider, rating: Int) {
        RatingControllerUtilities().defaultProgressViewSettings(circularProgress: circularProgress)
        slider.value = Float(RatingControllerUtilities().sliderValueConversion(rating: rating))
        updateController(angle: Double(slider.value), sliderTag: slider.tag)
        circularProgress.animate(fromAngle: 0, toAngle: Double(slider.value), duration: 1) { completed in }
    }
    
    @IBAction func sliderDidChangeValue(_ sender: UISlider) {
        let angle = Double(sender.value)
        updateController(angle: angle, sliderTag: sender.tag)
    }
    
    func updateController(angle: Double, sliderTag: Int) {
        let initRating: Double = angle/RatingControllerUtilities.sliderMax
        let rating = Int(round(initRating * 100))
        let color = RatingControllerUtilities().progressColor(value: angle)
        let ratingText = "\(rating)"
        switch sliderTag {
        case 0:
            self.relevance = rating
            relevanceCircularProgress.angle = angle
            relevanceCircularProgress.setColors(colors: color)
            relevanceLabel.textColor = color
            relevanceLabel.text = ratingText
        case 1:
            self.reliability = rating
            reliabilityCircularProgress.angle = angle
            reliabilityCircularProgress.setColors(colors: color)
            reliabilityLabel.textColor = color
            reliabilityLabel.text = ratingText
        default: break
        }
    }

    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        let newRelevance = RelevanceRatingFactory().create(creationDate: Date(), rating: relevance, modelId: (evidence?.evidenceId)!, userId: "")
        RelevanceRatingController.sharedInstance.update(key: newRelevance.ratingId, item: newRelevance as! RelevanceRating)
        RelevanceRatingController.sharedInstance.save()
        let newreliability = ReliabilityRatingFactory().create(creationDate: Date(), rating: reliability, modelId: (evidence?.evidenceId)!, userId: "")
        ReliabilityRatingController.sharedInstance.update(key: newreliability.ratingId, item: newreliability as! ReliabilityRating)
        ReliabilityRatingController.sharedInstance.save()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}

//
//  ClaimRatingViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/16/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class ClaimRatingViewController: UIViewController {
    
    weak var claim: Claim?
    var rating: Int = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var circularProgress: KDCircularProgress!
    @IBOutlet weak var probabilityLabel: UILabel!
    @IBOutlet weak var customNavigationItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let claim = claim {
            customNavigationItem.title = "\(claim.title)"
        } else {
            customNavigationItem.title = "Rate this Claim"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rating = RatingController.sharedInstance.latestRating(modelId: (claim?.claimId)!)
        setUpProgressView(circularProgress: circularProgress, slider: slider)
    }
    
    func setUpProgressView(circularProgress: KDCircularProgress, slider: UISlider) {
        RatingController.sharedInstance.defaultProgressViewSettings(circularProgress: circularProgress)
        slider.value = Float(RatingController.sharedInstance.sliderValueConversion(rating: rating))
        updateController(angle: Double(slider.value))
        circularProgress.animate(fromAngle: 0, toAngle: Double(slider.value), duration: 1) { completed in }
    }
    
    @IBAction func sliderDidChangeValue(_ sender: UISlider) {
        circularProgress.angle = Double(sender.value)
        updateController(angle: circularProgress.angle)
    }
    
    func updateController(angle: Double) {
        let initRating: Double = angle/RatingController.sliderMax
        let rating = Int(round(initRating * 100))
        let color = RatingController.sharedInstance.progressColor(value: angle)
        let probabilityText = "\(rating)"
        self.rating = rating
        circularProgress.angle = angle
        circularProgress.setColors(colors: color)
        probabilityLabel.textColor = color
        probabilityLabel.text = probabilityText
    }

    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        let newRating = RatingFactory().create(creationDate: Date(), rating: rating, modelId: (claim?.claimId)!, userId: "")
        RatingController.sharedInstance.update(key: newRating.ratingId, item: newRating)
        RatingController.sharedInstance.save()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}

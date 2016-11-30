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
        let ratings = RatingController.sharedInstance.all(modelId: (claim?.claimId)!)
        self.rating = ratings.count == 0 ? 50 : RatingController.sharedInstance.latestRating(ratings: ratings)
        setUpProgressView(circularProgress: circularProgress, slider: slider)
    }
    
    func setUpProgressView(circularProgress: KDCircularProgress, slider: UISlider) {
        RatingControllerUtilities().defaultProgressViewSettings(circularProgress: circularProgress)
        slider.value = Float(RatingControllerUtilities().sliderValueConversion(rating: rating))
        updateController(angle: Double(slider.value))
        circularProgress.animate(fromAngle: 0, toAngle: Double(slider.value), duration: 1) { completed in }
    }
    
    @IBAction func sliderDidChangeValue(_ sender: UISlider) {
        circularProgress.angle = Double(sender.value)
        updateController(angle: circularProgress.angle)
    }
    
    func updateController(angle: Double) {
        let initRating: Double = angle/RatingControllerUtilities.sliderMax
        let rating = Int(round(initRating * 100))
        let color = RatingControllerUtilities().progressColor(value: angle)
        let probabilityText = "\(rating)"
        self.rating = rating
        circularProgress.angle = angle
        circularProgress.setColors(colors: color)
        probabilityLabel.textColor = color
        probabilityLabel.text = probabilityText
    }

    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        let users = UserController.sharedInstance.all()
        let user = users.first!
        _ = RatingFactory().create(rating: rating, modelId: (claim?.claimId)!, userId: user.userId)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}

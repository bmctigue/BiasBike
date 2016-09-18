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
    var probability: Int = 0
    
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
        
        setUpProgressView(circularProgress: circularProgress, slider: slider)
    }
    
    func setUpProgressView(circularProgress: KDCircularProgress, slider: UISlider) {
        RatingController().defaultProgressViewSettings(circularProgress: circularProgress)
        slider.value = Float(RatingController().sliderValueConversion(rating: (claim?.probability)!))
        updateController(angle: Double(slider.value))
        circularProgress.animate(fromAngle: 0, toAngle: Double(slider.value), duration: 1) { completed in }
    }
    
    @IBAction func sliderDidChangeValue(_ sender: UISlider) {
        circularProgress.angle = Double(sender.value)
        updateController(angle: circularProgress.angle)
    }
    
    func updateController(angle: Double) {
        let initProb: Double = angle/RatingController.sliderMax
        let probability = Int(round(initProb * 100))
        let color = RatingController().progressColor(value: angle)
        let probabilityText = "\(probability)"
        self.probability = probability
        circularProgress.angle = angle
        circularProgress.setColors(colors: color)
        probabilityLabel.textColor = color
        probabilityLabel.text = probabilityText
    }

    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        claim?.probability = probability
        ClaimController.sharedInstance.update(key: (claim?.claimId)!, item: claim!)
        ClaimController.sharedInstance.save()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}

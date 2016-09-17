//
//  ClaimRatingViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/16/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class ClaimRatingViewController: UIViewController {
    
    var claim: Claim?
    var probability: Int = 0
    var progress: KDCircularProgress!
    static var sliderMax: Double = 360
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var circularProgress: KDCircularProgress!
    @IBOutlet weak var probabilityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circularProgress.startAngle = -90
        circularProgress.progressThickness = 0.2
        circularProgress.trackThickness = 0.6
        circularProgress.clockwise = true
        circularProgress.gradientRotateSpeed = 2
        circularProgress.roundedCorners = true
        circularProgress.glowMode = .noGlow
        circularProgress.glowAmount = 0.9
        circularProgress.setColors(colors: UIColor.red)
        circularProgress.center = CGPoint(x: view.center.x, y: view.center.y + 25)
        slider.value = Float(sliderValueConversion(probability: (claim?.probability)!))
        updateController(angle: Double(slider.value))
        circularProgress.animate(fromAngle: 0, toAngle: Double(slider.value), duration: 1) { completed in }
    }
    
    @IBAction func sliderDidChangeValue(_ sender: UISlider) {
        circularProgress.angle = Double(sender.value)
        updateController(angle: circularProgress.angle)
    }
    
    func updateController(angle: Double) {
        let prob: Double = angle/ClaimRatingViewController.sliderMax
        self.probability = Int(round(prob * 100))
        updateProgressColor(value: angle)
        updateProbabilityLabel()
    }
    
    func sliderValueConversion(probability: Int) -> Double {
        let value = Double(probability) / 100.0
        return value * ClaimRatingViewController.sliderMax
    }
    
    func updateProgressColor(value: Double) {
        var color: UIColor
        if value <= 90 {
            color = UIColor.red
        } else if value <= 180 {
            color = UIColor.orange
        } else if value <= 270 {
            color = Theme.Yellow.color
        } else {
            color = UIColor.green
        }
        circularProgress.setColors(colors: color)
        probabilityLabel.textColor = color
    }
    
    func updateProbabilityLabel() {
        probabilityLabel.text = "\(probability)%"
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

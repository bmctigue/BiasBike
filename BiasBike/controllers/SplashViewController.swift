//
//  SplashViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/22/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit
import RealmSwift

class SplashViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Theme.Dark.color
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        containerView.alpha = 1.0
        let trans: CGAffineTransform = containerView.transform.scaledBy(x: 0.01, y: 0.01)
        containerView.transform = trans
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, animations: {
            let trans: CGAffineTransform = self.containerView.transform.scaledBy(x: 100.0, y: 100.0)
            self.containerView.transform = trans
        }, completion: {
            (value: Bool) in
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when) {
                if configureDefaultRealm() {
                    self.openMainView()
                } else {
                    logIn(animated: false)
                }
            }
        })
    }
    
    private func openMainView() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard = StoryboardFactory().create(name: "Main")
        let controller: UITabBarController = storyboard.instantiateInitialViewController() as! UITabBarController
        appDelegate.window?.rootViewController = controller
        
        UIView.transition(with: appDelegate.window!, duration: 0.5, options: .transitionCrossDissolve, animations: {}, completion: {
            (value: Bool) in
            appDelegate.window?.rootViewController = controller
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

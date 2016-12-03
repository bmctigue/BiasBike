//
//  FallacyCollectionViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 10/4/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class FallacyCollectionViewController: UICollectionViewController {
    
    var fallacies: [Fallacy]?
    private(set) var collectionViewDataSource: FallacyCollectionViewDataSource?
    private(set) var collectionViewDelegateFlowLayout: FallacyCollectionViewDelegateFlowLayout?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let fallacies = fallacies {
            self.collectionViewDataSource = FallacyCollectionViewDataSource(collectionView: collectionView!, fallacies: fallacies)
            self.collectionViewDelegateFlowLayout = FallacyCollectionViewDelegateFlowLayout(collectionView: collectionView!, fallacies: fallacies, fallacyCollectionViewController: self)
        }
    }
}

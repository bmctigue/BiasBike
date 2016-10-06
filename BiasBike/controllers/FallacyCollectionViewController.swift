//
//  FallacyCollectionViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 10/4/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class FallacyCollectionViewController: UICollectionViewController {
    
    weak var evidence: Evidence?
    private(set) var collectionViewDataSource: FallacyCollectionViewDataSource?
    private(set) var collectionViewDelegateFlowLayout: FallacyCollectionViewDelegateFlowLayout?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViewDataSource = FallacyCollectionViewDataSource(collectionView: collectionView!, evidence: evidence)
        self.collectionViewDelegateFlowLayout = FallacyCollectionViewDelegateFlowLayout(collectionView: collectionView!, evidence: evidence, fallacyCollectionViewController: self)
    }

}

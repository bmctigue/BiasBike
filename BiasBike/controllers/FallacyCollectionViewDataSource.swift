//
//  FallacyCollectionViewDataSource.swift
//  BiasBike
//
//  Created by Bruce McTigue on 10/4/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class FallacyCollectionViewDataSource: NSObject {
    
    weak var evidence: Evidence?
    private(set) var fallacies:[Fallacy] = []
    
    init(collectionView: UICollectionView, evidence: Evidence?) {
        self.evidence = evidence
        if let evidence = evidence {
            self.fallacies = Array(evidence.fallacies)
        }
        super.init()
        collectionView.dataSource = self
    }
    
    func updateData() {
        if let evidence = evidence {
            self.fallacies = Array(evidence.fallacies)
        }
    }
}

extension FallacyCollectionViewDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fallacies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FallacyCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FallacyCollectionCell", for: indexPath) as! FallacyCollectionCell
        let fallacy = fallacies[indexPath.row]
        cell.updateCell(icon: fallacy.icon)
        return cell
    }

}

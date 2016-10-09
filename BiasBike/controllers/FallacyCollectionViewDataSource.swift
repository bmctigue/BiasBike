//
//  FallacyCollectionViewDataSource.swift
//  BiasBike
//
//  Created by Bruce McTigue on 10/4/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class FallacyCollectionViewDataSource: NSObject {
    
    private(set) var fallacies:[Fallacy] = []
    
    init(collectionView: UICollectionView, fallacies:[Fallacy]) {
        super.init()
        collectionView.dataSource = self
        self.fallacies = fallacies
    }
    
    func updateData(fallacies:[Fallacy]) {
        self.fallacies = fallacies
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
        return cell
    }

}

//
//  FallacyCollectionViewDelegateFlowLayout.swift
//  BiasBike
//
//  Created by Bruce McTigue on 10/4/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

private let sectionInsets = UIEdgeInsets(top: 7.0, left: 10.0, bottom: 7.0, right: 10.0)

class FallacyCollectionViewDelegateFlowLayout: NSObject {
    
    init(collectionView: UICollectionView) {
        super.init()
        collectionView.delegate = self
    }
}


extension FallacyCollectionViewDelegateFlowLayout : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30.0, height: 30.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

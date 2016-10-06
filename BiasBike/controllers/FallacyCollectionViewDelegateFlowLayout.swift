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
    
    weak var evidence: Evidence?
    private(set) var fallacies:[Fallacy] = []
    
    init(collectionView: UICollectionView, evidence: Evidence?) {
        super.init()
        collectionView.delegate = self
        if let evidence = evidence {
            self.fallacies = Array(evidence.fallacies)
        }
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

extension FallacyCollectionViewDelegateFlowLayout: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell:FallacyCollectionCell = cell as! FallacyCollectionCell
        let fallacy = fallacies[indexPath.row]
        cell.updateCell(icon: fallacy.icon)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
    }
    
}

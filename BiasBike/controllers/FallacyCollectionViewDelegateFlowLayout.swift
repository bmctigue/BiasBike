//
//  FallacyCollectionViewDelegateFlowLayout.swift
//  BiasBike
//
//  Created by Bruce McTigue on 10/4/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

private let sectionInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)

class FallacyCollectionViewDelegateFlowLayout: NSObject {
    
    private(set) var fallacies:[Fallacy] = []
    private(set) weak var fallacyCollectionViewController: FallacyCollectionViewController?
    
    init(collectionView: UICollectionView, fallacies: [Fallacy], fallacyCollectionViewController: FallacyCollectionViewController) {
        super.init()
        collectionView.delegate = self
        self.fallacies = fallacies
        self.fallacyCollectionViewController = fallacyCollectionViewController
    }
    
    func updateData(fallacies:[Fallacy]) {
        self.fallacies = fallacies
    }
}

extension FallacyCollectionViewDelegateFlowLayout : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 20.0, height: 20.0)
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
        let icon = fallacy.icon
        cell.updateCell(icon: icon)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fallacy = fallacies[indexPath.row]
        let storyboard = StoryboardFactory().create(name: "Fallacy")
        let controller: FallacyViewController = storyboard.instantiateViewController(withIdentifier: "FallacyViewController") as! FallacyViewController
        controller.fallacy = fallacy
        fallacyCollectionViewController?.show(controller, sender: nil)
    }
    
}

//
//  BaseViewController+CollectionView.swift
//  QuizApp
//
//  Created by Tarun Kumar on 3/20/21.
//  Copyright © 2021 Tarun Kumar. All rights reserved.
//

import UIKit

/// BaseViewController Extension Class to handle CollectionView Delagate Methods
extension BaseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, WebViewCollectionViewProtocol {
    
    // MARK: UICollectionViewDelegate Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return webViewsImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WebViewCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WebViewCollectionCell", for: indexPath) as! WebViewCollectionCell
        cell.setCellValues(webURL: webViews[indexPath.item].getCurrentUrl(), webImage: webViewsImages[indexPath.item], index: indexPath.item, delegate: self)
        cell.setSelected(isSelected: indexPath.item == currentTabIndex)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openTab(selectedIndex: indexPath.item)
    }
    
    //MARK: UICollectionViewDelegateFlowLayout Methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 235)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    // MARK: WebViewCollectionViewProtocol Methods
    
    func closeButtonPressed(webImage: UIImage) {
        removeCellAtIndexPath(index: webViewsImages.firstIndex(of: webImage)!)
    }
}

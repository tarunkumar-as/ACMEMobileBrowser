//
//  WebViewCollectionViewProtocol.swift
//  QuizApp
//
//  Created by Tarun Kumar on 3/21/21.
//  Copyright © 2021 Tarun Kumar. All rights reserved.
//

import UIKit

protocol WebViewCollectionViewProtocol: class {
    
    // MARK: Called when the close button of the collectionview cell is pressed
    func closeButtonPressed(webImage: UIImage)
}

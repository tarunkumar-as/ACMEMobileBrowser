//
//  ActionButtonProtocol.swift
//  QuizApp
//
//  Created by Tarun Kumar on 3/19/21.
//  Copyright © 2021 Tarun Kumar. All rights reserved.
//

protocol ActionButtonProtocol: class {
    
    // MARK: Called when the action button is pressed
    func actionButtonPressed(buttonType: ButtonType)
}

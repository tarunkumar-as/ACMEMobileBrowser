//
//  AddressBarProtocol.swift
//  QuizApp
//
//  Created by Tarun Kumar on 3/20/21.
//  Copyright © 2021 Tarun Kumar. All rights reserved.
//

protocol AddressBarProtocol: ActionButtonProtocol {
    
    // MARK: Called when input is given int he address bar
    func addressTyped(address: String)
}

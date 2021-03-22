//
//  WebViewDelegate.swift
//  QuizApp
//
//  Created by Tarun Kumar on 3/20/21.
//  Copyright © 2021 Tarun Kumar. All rights reserved.
//

protocol WebViewProtocol: class {
    
    // Called when the webview finished loading the web page
    func webPageCompletedLoading(url: String, isError: Bool)
    
    // Updates the progress of the webview
    func updateProgressOfWebview(progress: Float)
}

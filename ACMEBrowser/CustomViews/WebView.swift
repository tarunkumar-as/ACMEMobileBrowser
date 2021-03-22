//
//  WebViewController.swift
//  ACMEBrowser
//
//  Created by Tarun Kumar on 3/19/21.
//

import UIKit
import WebKit

class WebView: UIView, WKNavigationDelegate {

    // MARK: Initialization
    
    weak var webViewDelegate: WebViewProtocol?
    private var currentIndex = -1
    private var history: [URL] = []
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        webView.load(URLRequest(url: URL(string: "https://neeva.co/")!))
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        return webView
    }()
    
    private lazy var errorView: ErrorView = {
        let errorView = ErrorView()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.isHidden = true
        return errorView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupWebView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Customize View
    
    private func setupWebView() {
        addSubview(webView)
        addSubview(errorView)
        
        webView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        errorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        errorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        errorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        errorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    // MARK: Webview Related Methods
    
    func loadURl(url: String) {
        if let webUrl = URL(string: url) {
            webView.load(URLRequest(url: webUrl))
        }
        else {
            showErrorView(errorDesc: "Invalid URL")
        }
    }
    
    func hasNextElement() -> Bool {
        return currentIndex < history.count - 1
    }
    
    func hasPrevElement() -> Bool {
        return currentIndex > 0
    }
    
    func loadPrevUrl() {
        if hasPrevElement() {
            currentIndex -= 1
            webView.load(URLRequest(url: history[currentIndex]))
        }
    }
    
    func loadNextUrl() {
        if hasNextElement() {
            currentIndex += 1
            webView.load(URLRequest(url: history[currentIndex]))
        }
    }
    
    func getCurrentUrl() -> String {
        return webView.url!.absoluteString
    }
    
    // MARK: Error View
    
    private func showErrorView(errorDesc: String) {
        errorView.isHidden = false
        webView.isHidden = true
        errorView.updateError(errorDescription: errorDesc)
    }
    
    private func hideErrorView() {
        errorView.isHidden = true
        webView.isHidden = false
    }
    
    // MARK: WKNavigationDelegate Mathods
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            webViewDelegate?.updateProgressOfWebview(progress: Float(webView.estimatedProgress))
        }
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        if let currentUrl = webView.url {
            if currentIndex < history.count - 1 && currentUrl != history[currentIndex] {
                currentIndex += 1;
                history.removeSubrange(currentIndex ... history.count - 1)
                history.append(currentUrl)
            }
            else if (currentIndex == -1) || (currentIndex == history.count - 1 && currentUrl != history[currentIndex]) {
                history.append(currentUrl)
                currentIndex += 1
            }
        }
        webViewDelegate?.webPageCompletedLoading(url: webView.url!.absoluteString, isError: false)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideErrorView()
        webViewDelegate?.updateProgressOfWebview(progress: Float(1.0))
        webViewDelegate?.webPageCompletedLoading(url: webView.url!.absoluteString, isError: false)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showErrorView(errorDesc: error.localizedDescription)
        webViewDelegate?.updateProgressOfWebview(progress: Float(1.0))
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        showErrorView(errorDesc: error.localizedDescription)
        webViewDelegate?.updateProgressOfWebview(progress: Float(1.0))
    }
}

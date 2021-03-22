//
//  BaseViewController.swift
//  ACMEBrowser
//
//  Created by Tarun Kumar on 3/19/21.
//

import UIKit
import WebKit

class BaseViewController: UIViewController, ActionButtonProtocol, AddressBarProtocol, WebViewProtocol {
    
    //MARK: Initializations
    
    private var viewType: ViewType = .Home
    internal var currentTabIndex: Int = -2
    internal var webViews: [WebView] = []
    internal var webViewsImages: [UIImage] = []
    
    private var bottomBarConstraints: [NSLayoutConstraint] = []
    
    private lazy var bottomBarContainer: UIView = {
        let bottomBar = UIView()
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.backgroundColor = .white
        return bottomBar
    }()
    
    private lazy var bottomBar: BottomBar = {
        let bottomBar = BottomBar()
        bottomBar.actionButtonDelegate = self
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        return bottomBar
    }()
    
    private lazy var addressBarContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        return container
    }()
    
    private lazy var addressBar: AddressBar = {
        let addressBar = AddressBar()
        addressBar.actionButtonDelegate = self
        addressBar.translatesAutoresizingMaskIntoConstraints = false
        return addressBar
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isOpaque = true
        collectionView.backgroundColor = UIColor.black
        collectionView.alpha = 1.0
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.register(WebViewCollectionCell.self, forCellWithReuseIdentifier: "WebViewCollectionCell")
        collectionView.isHidden = true
        return collectionView
    }()
    
    private lazy var splitViewCloseButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.splitViewCloseButtonPressed(sender:)), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named: "close.png")!.imageWithColor(tintColor: .white), for: UIControl.State.normal)
        button.backgroundColor = UIColor(displayP3Red: 0.339, green: 0.632, blue: 0.968, alpha: 1.0)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.isHidden = true
        button.isEnabled = false
        return button
    }()
    
    private lazy var splitViewAddButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.splitViewAddButtonPressed(sender:)), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named: "add.png")!.imageWithColor(tintColor: .white), for: UIControl.State.normal)
        button.backgroundColor = UIColor(displayP3Red: 0.339, green: 0.632, blue: 0.968, alpha: 1.0)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.isHidden = true
        button.isEnabled = false
        return button
    }()
    
    // MARK: Customize ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        addBottomBar()
        addAddressBar()
        createNewTab()
        addCollectionView()
    }
    
    private func addBottomBar() {
        view.addSubview(bottomBarContainer)
        view.addSubview(bottomBar)
        
        bottomBarConstraints.append(bottomBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        bottomBarConstraints.append(bottomBar.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 5))
        bottomBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        bottomBarContainer.topAnchor.constraint(equalTo: bottomBar.topAnchor, constant: -10).isActive = true
        bottomBarContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomBarContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomBarContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func addAddressBar() {
        view.addSubview(addressBarContainer)
        view.addSubview(addressBar)
        
        addressBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addressBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        addressBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        addressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        
        addressBarContainer.bottomAnchor.constraint(equalTo: addressBar.bottomAnchor, constant: 5).isActive = true
        addressBarContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        addressBarContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        addressBarContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        viewType = getBrowserViewType()
        addressBar.addViewConstraints(isLandscape: !(viewType == .IPad || viewType == .Portrait))
        showHideBottomBar(isLandscape: !(viewType == .IPad || viewType == .Portrait))
    }
    
    private func addCollectionView() {
        view.addSubview(collectionView)
        view.addSubview(splitViewCloseButton)
        view.addSubview(splitViewAddButton)
        
        splitViewAddButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -35).isActive = true
        splitViewAddButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        splitViewAddButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        splitViewAddButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        splitViewCloseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 35).isActive = true
        splitViewCloseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        splitViewCloseButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        splitViewCloseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func showHideBottomBar(isLandscape: Bool) {
        if isLandscape {
            bottomBarConstraints[0].isActive = false
            bottomBarConstraints[1].isActive = true
            bottomBarContainer.isHidden = true
            
        }
        else {
            bottomBarConstraints[0].isActive = true
            bottomBarConstraints[1].isActive = false
            bottomBarContainer.isHidden = false
        }
    }
    
    private func getBrowserViewType() -> ViewType {
        if currentTabIndex == -1 {
            return .Home
        }
        else {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return .IPad
            }
            if UIDevice.current.orientation.isLandscape {
                return .Landscape
            }
            else {
                return .Portrait
            }
        }
    }
    
    // MARK: Handling New Tab Action
    
    private func createNewTab() {
        let webView: WebView =  WebView()
        webView.webViewDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webViews.append(webView)
        currentTabIndex = webViews.count - 1
        addWebView()
    }
    
    private func addWebView() {
        
        let currentWebView = webViews[currentTabIndex]
        
        for webview in webViews {
            if webview != currentWebView {
                webview.isHidden = true
            }
            else {
                webview.isHidden = false
            }
        }
        
        view.addSubview(currentWebView)
        currentWebView.topAnchor.constraint(equalTo: addressBarContainer.bottomAnchor).isActive = true
        currentWebView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        currentWebView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        currentWebView.bottomAnchor.constraint(equalTo: bottomBar.topAnchor, constant: -5).isActive = true
    }
    
    // MARK: Handling SplitView Action
    
    private func splitViewButtonPressed() {
        bottomBarContainer.isHidden = true
        bottomBar.isHidden = true
        
        addressBarContainer.isHidden = true
        addressBar.isHidden = true
        
        collectionView.isHidden = false
        
        splitViewAddButton.isHidden = false
        splitViewAddButton.isEnabled = true
        
        splitViewCloseButton.isHidden = false
        splitViewCloseButton.isEnabled = true
        splitViewCloseButton.backgroundColor = UIColor(displayP3Red: 0.339, green: 0.632, blue: 0.968, alpha: 1.0)
        
        for webview in webViews {
            webview.isHidden = true
        }
        
        collectionView.reloadData()
    }
    
    private func takeScreenshot() {
        webViewsImages.append(webViews[currentTabIndex].takeScreenshot())
    }
    
    @objc private func splitViewCloseButtonPressed(sender: UIButton) {
        if currentTabIndex >= webViews.count {
            currentTabIndex = webViews.count - 1
        }
        openTab(selectedIndex: currentTabIndex)
    }
    
    @objc private func splitViewAddButtonPressed(sender: UIButton) {
        bottomBarContainer.isHidden = false
        bottomBar.isHidden = false
        
        addressBarContainer.isHidden = false
        addressBar.isHidden = false
        
        collectionView.isHidden = true
        
        splitViewAddButton.isHidden = true
        splitViewAddButton.isEnabled = false
        
        splitViewCloseButton.isHidden = true
        splitViewCloseButton.isEnabled = false
        createNewTab()
    }
    
    internal func openTab(selectedIndex: Int) {
        bottomBarContainer.isHidden = false
        bottomBar.isHidden = false
        
        addressBarContainer.isHidden = false
        addressBar.isHidden = false
        
        collectionView.isHidden = true
        
        splitViewAddButton.isHidden = true
        splitViewAddButton.isEnabled = false
        
        splitViewCloseButton.isHidden = true
        splitViewCloseButton.isEnabled = false
        
        let webView = webViews.remove(at: selectedIndex)
        webViewsImages.remove(at: selectedIndex)
        webViews.append(webView)
        
        currentTabIndex = webViews.count - 1
        webViews[currentTabIndex].isHidden = false
    }
    
    internal func removeCellAtIndexPath(index: Int) {
        webViews.remove(at: index)
        webViewsImages.remove(at: index)
        collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
        collectionView.reloadData()
        if webViews.count == 0 {
            splitViewCloseButton.isEnabled = false
            splitViewCloseButton.backgroundColor = .lightGray
        }
    }
    
    private func reloadWebView() {
        let currentWebView = webViews[currentTabIndex]
        currentWebView.loadURl(url: currentWebView.getCurrentUrl())
    }
    
    // MARK: AddressBarProtocol Delegate Methods
    
    func addressTyped(address: String) {
        webViews[currentTabIndex].loadURl(url: address)
    }
    
    // MARK: ActionButtonProtocol Delegate Methods
    
    func actionButtonPressed(buttonType: ButtonType) {
        switch buttonType {
        case .Back:
            webViews[currentTabIndex].loadPrevUrl()
            break
        case .Front:
            webViews[currentTabIndex].loadNextUrl()
            break
        case .Add:
            takeScreenshot()
            createNewTab()
            break
        case .SplitView:
            takeScreenshot()
            splitViewButtonPressed()
            break
        case .Reload:
            reloadWebView()
            break
        }
    }
    
    // MARK: WebViewProtocol Delegate Methods
    
    func webPageCompletedLoading(url: String, isError: Bool) {
        addressBar.updateActionButton(backEnabled: webViews[currentTabIndex].hasPrevElement(), fronEnabled: webViews[currentTabIndex].hasNextElement())
        bottomBar.updateActionButton(backEnabled: webViews[currentTabIndex].hasPrevElement(), fronEnabled: webViews[currentTabIndex].hasNextElement())
        addressBar.updateAddressbar(url: url)
    }
    
    func updateProgressOfWebview(progress: Float) {
        addressBar.updateStatusOfWebPage(progress: progress)
    }
    
    // MARK: View Delegate Methods
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        viewType = getBrowserViewType()
        addressBar.addViewConstraints(isLandscape: !(viewType == .IPad || viewType == .Portrait))
        showHideBottomBar(isLandscape: !(viewType == .IPad || viewType == .Portrait))
    }
}

//
//  WebViewController.swift
//  ACMEBrowser
//
//  Created by Tarun Kumar on 3/19/21.
//

import UIKit

class ErrorView: UIView {

    // MARK: Initialization
    
    private lazy var errorImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "error.png")?.imageWithColor(tintColor: UIColor.gray))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var errorTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ERROR"
        label.textColor = UIColor.gray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var errorSubtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reload the page or enter a different URL"
        label.textColor = UIColor.gray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        initializeView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Customize View
    
    private func initializeView() {
        addSubview(errorImage)
        addSubview(errorTitle)
        addSubview(errorSubtitle)
        
        errorImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        errorImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        errorImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        errorImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50).isActive = true
        
        errorTitle.topAnchor.constraint(equalTo: errorImage.bottomAnchor, constant: 10).isActive = true
        errorTitle.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        errorTitle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        errorSubtitle.topAnchor.constraint(equalTo: errorTitle.bottomAnchor, constant: 10).isActive = true
        errorSubtitle.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        errorSubtitle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func updateError(errorDescription: String) {
        errorTitle.text = errorDescription
    }
}

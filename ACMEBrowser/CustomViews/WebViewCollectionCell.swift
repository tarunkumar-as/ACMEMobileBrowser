//
//  WebViewCollectionCell.swift
//  QuizApp
//
//  Created by Tarun Kumar on 3/21/21.
//  Copyright © 2021 Tarun Kumar. All rights reserved.
//

import UIKit

class WebViewCollectionCell: UICollectionViewCell {
    
    // MARK: Initialization
    
    private weak var cellDelegate: WebViewCollectionViewProtocol?
    
    private var cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var webViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.black
        return label
    }()
    
    private lazy var webViewImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.closeButtonPressed(sender:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private lazy var closeImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "close.png")!.imageWithColor(tintColor: .white))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addCellViewConstraints()
    }
    
    // MARK: Customize CollectionViewCell
    
    private func addCellViewConstraints() {
        contentView.addSubview(cellView)
        cellView.addSubview(webViewLabel)
        cellView.addSubview(webViewImage)
        cellView.addSubview(closeButton)
        closeButton.addSubview(closeImage)
        
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        webViewLabel.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
        webViewLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10).isActive = true
        webViewLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -35).isActive = true
        webViewLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        webViewImage.topAnchor.constraint(equalTo: webViewLabel.bottomAnchor).isActive = true
        webViewImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor).isActive = true
        webViewImage.trailingAnchor.constraint(equalTo: cellView.trailingAnchor).isActive = true
        webViewImage.bottomAnchor.constraint(equalTo: cellView.bottomAnchor).isActive = true
        
        closeButton.trailingAnchor.constraint(equalTo: cellView.trailingAnchor).isActive = true
        closeButton.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        closeImage.centerXAnchor.constraint(equalTo: closeButton.centerXAnchor).isActive = true
        closeImage.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        closeImage.heightAnchor.constraint(equalToConstant: 15).isActive = true
        closeImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    // MARK: Updating the cell based on the input values
    
    public func setCellValues(webURL: String, webImage: UIImage, index: Int, delegate: WebViewCollectionViewProtocol) {
        webViewLabel.text = webURL
        webViewImage.image = webImage
        closeButton.tag = index
        cellDelegate = delegate
    }
    
    public func setSelected(isSelected: Bool) {
        cellView.layer.borderColor = isSelected ? UIColor(displayP3Red: 0.339, green: 0.632, blue: 0.968, alpha: 1.0).cgColor : UIColor.black.cgColor
    }
    
    // MARK: Button Handle Events
    
    @objc private func closeButtonPressed(sender: UIButton) {
        cellDelegate?.closeButtonPressed(webImage: webViewImage.image!)
    }
}

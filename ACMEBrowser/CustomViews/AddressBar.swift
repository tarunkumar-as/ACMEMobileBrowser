//
//  AddressBar.swift
//  QuizApp
//
//  Created by Tarun Kumar on 3/19/21.
//  Copyright © 2021 Tarun Kumar. All rights reserved.
//

import UIKit

class AddressBar: UIView, UITextFieldDelegate {
    
    // MARK: Initialization
    
    weak var actionButtonDelegate: AddressBarProtocol?
    
    private var activeColor = UIColor(displayP3Red: 0.339, green: 0.632, blue: 0.968, alpha: 1.0)
    private var disableColor = UIColor.lightGray
    
    private var landscapeConstraints: [NSLayoutConstraint] = []
    private var portraitConstraints: [NSLayoutConstraint] = []
    
    private lazy var textViewContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var textView: TextField = {
        let textView = TextField()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.delegate = self
        textView.layer.cornerRadius = 5
        textView.autocapitalizationType = .none
        textView.returnKeyType = .go
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.gray.cgColor
        return textView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 0
        button.setImage(UIImage(named: "left-arrow.png")?.imageWithColor(tintColor: activeColor), for: UIControl.State.normal)
        button.setImage(UIImage(named: "left-arrow.png")?.imageWithColor(tintColor: disableColor), for: UIControl.State.disabled)
        button.addTarget(self, action: #selector(self.buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private lazy var frontButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 1
        button.setImage(UIImage(named: "right-arrow-angle.png")?.imageWithColor(tintColor: activeColor), for: UIControl.State.normal)
        button.setImage(UIImage(named: "right-arrow-angle.png")?.imageWithColor(tintColor: disableColor), for: UIControl.State.disabled)
        button.addTarget(self, action: #selector(self.buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        button.isEnabled = false
        return button
    }()

    private lazy var addButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 2
        button.setImage(UIImage(named: "add.png")?.imageWithColor(tintColor: activeColor), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(self.buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        return button
    }()

    private lazy var tabsButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 3
        button.setImage(UIImage(named: "front.png")?.imageWithColor(tintColor: activeColor), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(self.buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        return button
    }()

    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 4
        button.setImage(UIImage(named: "reload.png")?.imageWithColor(tintColor: activeColor), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(self.buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private lazy var progressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Cutomize View
    
    private func customizeView() {
        addSubview(textView)
        addSubview(backButton)
        addSubview(frontButton)
        addSubview(addButton)
        addSubview(tabsButton)
        addSubview(settingsButton)
        addSubview(progressBar)
    
        setPortraitConstraints()
        setLandscapeConstraints()
        addProgressBarConstraints()
    }
    
    private func setPortraitConstraints() {
        portraitConstraints.append(textView.topAnchor.constraint(equalTo: self.topAnchor))
        portraitConstraints.append(textView.leadingAnchor.constraint(equalTo: self.leadingAnchor))
        portraitConstraints.append(textView.trailingAnchor.constraint(equalTo: self.trailingAnchor))
        portraitConstraints.append(textView.bottomAnchor.constraint(equalTo: self.bottomAnchor))
    }
    
    private func setLandscapeConstraints() {
        landscapeConstraints.append(backButton.heightAnchor.constraint(equalToConstant: 30))
        landscapeConstraints.append(backButton.widthAnchor.constraint(equalToConstant: 30))
        landscapeConstraints.append(backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor))
        landscapeConstraints.append(backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10))
        
        landscapeConstraints.append(frontButton.heightAnchor.constraint(equalToConstant: 30))
        landscapeConstraints.append(frontButton.widthAnchor.constraint(equalToConstant: 30))
        landscapeConstraints.append(frontButton.centerYAnchor.constraint(equalTo: self.centerYAnchor))
        landscapeConstraints.append(frontButton.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 10))
        
        landscapeConstraints.append(textView.heightAnchor.constraint(equalToConstant: 30))
        landscapeConstraints.append(textView.centerYAnchor.constraint(equalTo: self.centerYAnchor))
        landscapeConstraints.append(textView.leadingAnchor.constraint(equalTo: frontButton.trailingAnchor, constant: 10))
        landscapeConstraints.append(textView.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -10))
        
        landscapeConstraints.append(addButton.heightAnchor.constraint(equalToConstant: 30))
        landscapeConstraints.append(addButton.widthAnchor.constraint(equalToConstant: 30))
        landscapeConstraints.append(addButton.centerYAnchor.constraint(equalTo: self.centerYAnchor))
        landscapeConstraints.append(addButton.trailingAnchor.constraint(equalTo: tabsButton.leadingAnchor, constant: -10))
        
        landscapeConstraints.append(tabsButton.heightAnchor.constraint(equalToConstant: 30))
        landscapeConstraints.append(tabsButton.widthAnchor.constraint(equalToConstant: 30))
        landscapeConstraints.append(tabsButton.centerYAnchor.constraint(equalTo: self.centerYAnchor))
        landscapeConstraints.append(tabsButton.trailingAnchor.constraint(equalTo: settingsButton.leadingAnchor, constant: -10))
        
        landscapeConstraints.append(settingsButton.heightAnchor.constraint(equalToConstant: 30))
        landscapeConstraints.append(settingsButton.widthAnchor.constraint(equalToConstant: 30))
        landscapeConstraints.append(settingsButton.centerYAnchor.constraint(equalTo: self.centerYAnchor))
        landscapeConstraints.append(settingsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10))
    }
    
    private func addProgressBarConstraints() {
        progressBar.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        progressBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        progressBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func addViewConstraints(isLandscape: Bool) {
        backButton.isHidden = !isLandscape
        frontButton.isHidden = !isLandscape
        addButton.isHidden = !isLandscape
        tabsButton.isHidden = !isLandscape
        settingsButton.isHidden = !isLandscape
        for layout in portraitConstraints {
            layout.isActive = !isLandscape
        }
        for layout in landscapeConstraints {
            layout.isActive = isLandscape
        }
    }
    
    // MARK: AddressBar Updation Method
    
    func updateAddressbar(url: String) {
        textView.text = url
    }
    
    func updateActionButton(backEnabled: Bool, fronEnabled: Bool) {
        backButton.isEnabled = backEnabled
        frontButton.isEnabled = fronEnabled
    }
    
    func updateStatusOfWebPage(progress: Float) {
        if progress == 1.0 {
            progressBar.isHidden = true
        }
        else {
            progressBar.isHidden = false
            progressBar.progress = progress
        }
    }
    
    // MARK: Button Press Handle Method
    
    @objc private func buttonPressed(sender: UIButton) {
        actionButtonDelegate?.actionButtonPressed(buttonType: ButtonType(rawValue: sender.tag)!)
    }
    
    // MARK: UITextViewDelegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let inputText: String = textField.text!
        let inputAddress: String = inputText.hasPrefix("http") || inputText == "" ? inputText
            : "https://" + inputText
        actionButtonDelegate?.addressTyped(address: inputAddress)
        textField.text = inputAddress
        textField.resignFirstResponder()
        return true
    }
}

//
//  BottomBar.swift
//  QuizApp
//
//  Created by Tarun Kumar on 3/19/21.
//  Copyright © 2021 Tarun Kumar. All rights reserved.
//

import UIKit

class BottomBar: UIStackView {
    
    // MARK: Initialization
    
    weak var actionButtonDelegate: ActionButtonProtocol?
    
    private var activeColor = UIColor(displayP3Red: 0.339, green: 0.632, blue: 0.968, alpha: 1.0)
    private var disableColor = UIColor.lightGray
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.tag = 0
        button.setImage(UIImage(named: "left-arrow.png")?.imageWithColor(tintColor: activeColor), for: UIControl.State.normal)
        button.setImage(UIImage(named: "left-arrow.png")?.imageWithColor(tintColor: disableColor), for: UIControl.State.disabled)
        button.addTarget(self, action: #selector(self.buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private lazy var frontButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.tag = 1
        button.setImage(UIImage(named: "right-arrow-angle.png")?.imageWithColor(tintColor: activeColor), for: UIControl.State.normal)
        button.setImage(UIImage(named: "right-arrow-angle.png")?.imageWithColor(tintColor: disableColor), for: UIControl.State.disabled)
        button.addTarget(self, action: #selector(self.buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        button.isEnabled = false
        return button
    }()

    private lazy var addButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.tag = 2
        button.setImage(UIImage(named: "add.png")?.imageWithColor(tintColor: activeColor), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(self.buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        return button
    }()

    private lazy var tabsButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.tag = 3
        button.setImage(UIImage(named: "front.png")?.imageWithColor(tintColor: activeColor), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(self.buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        return button
    }()

    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.tag = 4
        button.setImage(UIImage(named: "reload.png")?.imageWithColor(tintColor: activeColor), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(self.buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private lazy var frontSpacer: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        return view
    }()
    
    private lazy var endSpacer: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeStackProperties()
        customizeView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Customize View
    
    private func customizeStackProperties() {
        self.axis = NSLayoutConstraint.Axis.horizontal
        self.distribution = UIStackView.Distribution.equalSpacing
        self.alignment = UIStackView.Alignment.fill
        self.backgroundColor = .white
    }
    
    private func customizeView() {
        self.addArrangedSubview(frontSpacer)
        self.addArrangedSubview(backButton)
        self.addArrangedSubview(frontButton)
        self.addArrangedSubview(addButton)
        self.addArrangedSubview(tabsButton)
        self.addArrangedSubview(settingsButton)
        self.addArrangedSubview(endSpacer)
    }
    
    func updateActionButton(backEnabled: Bool, fronEnabled: Bool) {
        backButton.isEnabled = backEnabled
        frontButton.isEnabled = fronEnabled
    }
    
    // MARK: Button Press Handle Method
    
    @objc private func buttonPressed(sender: UIButton) {
        actionButtonDelegate?.actionButtonPressed(buttonType: ButtonType(rawValue: sender.tag)!)
    }
}

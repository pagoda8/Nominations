//
//  PrimaryButton.swift
//  Nominations
//
//  Created by Wojtek on 22/10/2023.
//
//	Button used for primary actions

import UIKit

class PrimaryButton: UIButton {

	private var title: String = String()
	private var actionHandler: (() -> Void)?
	
	// Update button's appearance when the isEnabled property is changed
	override var isEnabled: Bool {
		didSet {
			super.isEnabled = isEnabled
			backgroundColor = isEnabled ? .black : .lightGray
		}
	}
	
	// Initialize button with title
	init(title: String) {
		super.init(frame: .zero)
		self.title = title.uppercased()
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// Setup button
	private func setup() {
		backgroundColor = .black
		
		setTitleColor(.white, for: .normal)
		setTitle(title, for: .normal)
		titleLabel?.font = UIFont.style.button
		
		layer.cornerRadius = 0
		
		addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
	}
	
	// When button is tapped
	@objc private func buttonTapped(_ sender: UIButton) {
		if isEnabled {
			actionHandler?()
		}
	}
	
	// Set behaviour for tap action
	func setActionHandler(_ handler: (() -> Void)?) {
		actionHandler = handler
	}
}

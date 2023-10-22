//
//  PrimaryButton.swift
//  Nominations
//
//  Created by Wojtek on 22/10/2023.
//

import UIKit

class PrimaryButton: UIButton {

	private var title: String = String()
	private var actionHandler: (() -> Void)?
	
	override var isEnabled: Bool {
		didSet {
			super.isEnabled = isEnabled
			backgroundColor = isEnabled ? .black : .lightGray
		}
	}
	
	// MARK: - Initialization
	
	init(title: String) {
		super.init(frame: .zero)
		self.title = title.uppercased()
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Private
	
	private func setup() {
		backgroundColor = .black
		
		setTitleColor(.white, for: .normal)
		setTitle(title, for: .normal)
		titleLabel?.font = UIFont.style.button
		
		layer.cornerRadius = 0
		
		addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
	}
	
	// MARK: - Action
	
	@objc private func buttonTapped(_ sender: UIButton) {
		if isEnabled {
			actionHandler?()
		}
	}
	
	// MARK: - Public
	
	func setActionHandler(_ handler: (() -> Void)?) {
		actionHandler = handler
	}

}

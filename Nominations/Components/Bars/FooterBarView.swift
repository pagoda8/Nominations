//
//  FooterBarView.swift
//  Nominations
//
//  Created by Wojtek on 22/10/2023.
//
//	Footer bar containing button(s)

import UIKit

class FooterBarView: UIView {
	
	private let padding: CGFloat = 23
	
	// hStack that holds button(s)
	private let hStack: UIStackView = {
		let hStack = UIStackView()
		hStack.axis = .horizontal
		hStack.spacing = 10
		hStack.translatesAutoresizingMaskIntoConstraints = false
		return hStack
	}()

	init() {
		super.init(frame: .zero)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// Setup view
	private func setup() {
		backgroundColor = .cubeLightGrey
		addShadow()
		
		// Add and setup hStack
		addSubview(hStack)
		NSLayoutConstraint.activate([
			hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
			hStack.topAnchor.constraint(equalTo: topAnchor, constant: padding),
			hStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
			hStack.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	// Add shadow to footer bar
	private func addShadow() {
		layer.shadowColor = UIColor.shadowStrong.cgColor
		layer.shadowOpacity = 1
		layer.shadowOffset = CGSize(width: 0, height: -2)
		layer.shadowRadius = 10
	}

	// Add button to footer bar
	func addButton(_ button: UIButton) {
		hStack.addArrangedSubview(button)
	}
}

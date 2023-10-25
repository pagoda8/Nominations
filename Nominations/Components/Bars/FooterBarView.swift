//
//  FooterBarView.swift
//  Nominations
//
//  Created by Wojtek on 22/10/2023.
//

import UIKit

class FooterBarView: UIView {
	
	private let hStack: UIStackView = {
		let hStack = UIStackView()
		hStack.axis = .horizontal
		hStack.spacing = 10
		hStack.translatesAutoresizingMaskIntoConstraints = false
		return hStack
	}()
	
	private let padding: CGFloat = 23

	init() {
		super.init(frame: .zero)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setup() {
		backgroundColor = .cubeLightGrey
		addShadow()
		
		addSubview(hStack)
		NSLayoutConstraint.activate([
			hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
			hStack.topAnchor.constraint(equalTo: topAnchor, constant: padding),
			hStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
			hStack.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	private func addShadow() {
		layer.shadowColor = UIColor.shadowStrong.cgColor
		layer.shadowOpacity = 1
		layer.shadowOffset = CGSize(width: 0, height: -2)
		layer.shadowRadius = 10
	}

	func addButton(_ button: UIButton) {
		hStack.addArrangedSubview(button)
	}
}

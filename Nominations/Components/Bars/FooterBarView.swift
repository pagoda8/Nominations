//
//  FooterBarView.swift
//  Nominations
//
//  Created by Wojtek on 22/10/2023.
//

import UIKit

class FooterBarView: UIView {
	
	private var hStack: UIStackView = UIStackView()

	init() {
		super.init(frame: .zero)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setup() {
		backgroundColor = .cubeLightGrey
		layer.shadowColor = UIColor.shadowStrong.cgColor
		layer.shadowOpacity = 1
		layer.shadowOffset = CGSize(width: 0, height: -2)
		layer.shadowRadius = 10
		
		hStack.axis = .horizontal
		hStack.spacing = 10
		hStack.translatesAutoresizingMaskIntoConstraints = false
		addSubview(hStack)
		NSLayoutConstraint.activate([
			hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
			hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23),
			hStack.topAnchor.constraint(equalTo: topAnchor, constant: 23),
			hStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -23),
			hStack.heightAnchor.constraint(equalToConstant: 50)
		])
	}

	func addButton(_ button: UIButton) {
		hStack.addArrangedSubview(button)
	}
}

//
//  NominationView.swift
//  Nominations
//
//  Created by Wojtek on 25/10/2023.
//

import UIKit

class NominationView: UIView {
	
	private var nomineeName: String = String()
	private var reason: String = String()
	
	private var vStackLeadingConstraint: NSLayoutConstraint?
	private var vStackTrailingConstraint: NSLayoutConstraint?
	
	private let padding: CGFloat = 23
	
	private var nameLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.lineBreakMode = .byTruncatingTail
		label.numberOfLines = 1
		label.textColor = .black
		label.font = UIFont.style.bodyBold
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private var reasonLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.lineBreakMode = .byTruncatingTail
		label.numberOfLines = 1
		label.textColor = .cubeDarkGrey
		label.font = UIFont.style.body
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let vStack: UIStackView = {
		let vStack = UIStackView()
		vStack.axis = .vertical
		vStack.alignment = .leading
		vStack.spacing = 10
		vStack.translatesAutoresizingMaskIntoConstraints = false
		return vStack
	}()
	
	private let spacerLine: UIView = {
		let spacer = UIView()
		spacer.backgroundColor = .cubeMidGrey
		spacer.translatesAutoresizingMaskIntoConstraints = false
		spacer.heightAnchor.constraint(equalToConstant: 1).isActive = true
		return spacer
	}()
	
	init(nomineeName: String, reason: String) {
		super.init(frame: .zero)
		self.nomineeName = nomineeName
		self.reason = reason
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		guard let leadingConstraint = vStackLeadingConstraint, let trailingConstraint = vStackTrailingConstraint else {
			return
		}
		let inset = safeAreaInsets.left
		leadingConstraint.constant = inset + padding
		trailingConstraint.constant = -inset - padding
	}
	
	private func setup() {
		setupLabels()
		
		vStack.addArrangedSubview(nameLabel)
		vStack.addArrangedSubview(reasonLabel)
		
		addSubview(vStack)
		vStackLeadingConstraint = vStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding)
		vStackTrailingConstraint = vStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
		vStackLeadingConstraint?.isActive = true
		vStackTrailingConstraint?.isActive = true
		NSLayoutConstraint.activate([
			vStack.topAnchor.constraint(equalTo: topAnchor, constant: padding),
		])
		
		addSubview(spacerLine)
		NSLayoutConstraint.activate([
			spacerLine.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: padding),
			spacerLine.bottomAnchor.constraint(equalTo: bottomAnchor),
			spacerLine.leadingAnchor.constraint(equalTo: leadingAnchor),
			spacerLine.trailingAnchor.constraint(equalTo: trailingAnchor),
		])
	}
	
	private func setupLabels() {
		nameLabel.text = nomineeName
		reasonLabel.text = reason
	}

}

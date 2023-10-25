//
//  NominationView.swift
//  Nominations
//
//  Created by Wojtek on 25/10/2023.
//
//	View that shows nomination's details

import UIKit

class NominationView: UIView {
	
	private var nomineeName: String = String()
	private var reason: String = String()
	
	private var vStackLeadingConstraint: NSLayoutConstraint?
	private var vStackTrailingConstraint: NSLayoutConstraint?
	
	private let padding: CGFloat = 23
	
	// Label showing nominee's full name
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

	// Label showing reason of nomination
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
	
	// vStack containing name label and reason label
	private let vStack: UIStackView = {
		let vStack = UIStackView()
		vStack.axis = .vertical
		vStack.alignment = .leading
		vStack.spacing = 10
		vStack.translatesAutoresizingMaskIntoConstraints = false
		return vStack
	}()
	
	// Horizontal line at the bottom of the view
	private let spacerLine: UIView = {
		let spacer = UIView()
		spacer.backgroundColor = .cubeMidGrey
		spacer.translatesAutoresizingMaskIntoConstraints = false
		spacer.heightAnchor.constraint(equalToConstant: 1).isActive = true
		return spacer
	}()
	
	// Initialize view with nominee's name and nomination reason
	init(nomineeName: String, reason: String) {
		super.init(frame: .zero)
		self.nomineeName = nomineeName
		self.reason = reason
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// Update vStack's left & right constraints when device rotates
	override func layoutSubviews() {
		super.layoutSubviews()
		
		guard let leadingConstraint = vStackLeadingConstraint, let trailingConstraint = vStackTrailingConstraint else {
			return
		}
		let inset = safeAreaInsets.left
		leadingConstraint.constant = inset + padding
		trailingConstraint.constant = -inset - padding
	}
	
	// Setup view
	private func setup() {
		setupLabels()
		
		// Add name and reason labels to vStack
		vStack.addArrangedSubview(nameLabel)
		vStack.addArrangedSubview(reasonLabel)
		
		// Add and setup vStack
		addSubview(vStack)
		vStackLeadingConstraint = vStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding)
		vStackTrailingConstraint = vStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
		vStackLeadingConstraint?.isActive = true
		vStackTrailingConstraint?.isActive = true
		NSLayoutConstraint.activate([
			vStack.topAnchor.constraint(equalTo: topAnchor, constant: padding),
		])
		
		// Add and setup spacer line
		addSubview(spacerLine)
		NSLayoutConstraint.activate([
			spacerLine.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: padding),
			spacerLine.bottomAnchor.constraint(equalTo: bottomAnchor),
			spacerLine.leadingAnchor.constraint(equalTo: leadingAnchor),
			spacerLine.trailingAnchor.constraint(equalTo: trailingAnchor),
		])
	}
	
	// Set the text for name and reason labels
	private func setupLabels() {
		nameLabel.text = nomineeName
		reasonLabel.text = reason
	}
}

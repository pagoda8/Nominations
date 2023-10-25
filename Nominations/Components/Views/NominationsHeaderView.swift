//
//  NominationsHeaderView.swift
//  Nominations
//
//  Created by Wojtek on 22/10/2023.
//

import UIKit

class NominationsHeaderView: UIView {
	
	private var titleLabelLeadingConstraint: NSLayoutConstraint?
	private var titleLabelTrailingConstraint: NSLayoutConstraint?
	
	private let titlePadding: CGFloat = 23

	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Your Nominations".uppercased()
		label.textAlignment = .left
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 0
		label.textColor = .black
		label.font = UIFont.style.boldHeadlineMedium
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let backgroundImageView: UIImageView = {
		let imageView = UIImageView(image: UIImage.greenBlobs)
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	init() {
		super.init(frame: .zero)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		guard let leadingConstraint = titleLabelLeadingConstraint, let trailingConstraint = titleLabelTrailingConstraint else {
			return
		}
		let inset = safeAreaInsets.left
		leadingConstraint.constant = inset + titlePadding
		trailingConstraint.constant = -inset - titlePadding
	}
	
	private func setup() {
		backgroundColor = .cubeGreen2
		clipsToBounds = true
		
		addSubview(backgroundImageView)
		NSLayoutConstraint.activate([
			backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			backgroundImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 140),
		])
		
		addSubview(titleLabel)
		titleLabelLeadingConstraint = titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: titlePadding)
		titleLabelTrailingConstraint = titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -titlePadding)
		titleLabelLeadingConstraint?.isActive = true
		titleLabelTrailingConstraint?.isActive = true
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: titlePadding),
			titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -titlePadding),
		])
	}

}

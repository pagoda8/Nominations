//
//  NominationsHeaderView.swift
//  Nominations
//
//  Created by Wojtek on 22/10/2023.
//

import UIKit

class NominationsHeaderView: UIView {
	
	private var textViewLeadingConstraint: NSLayoutConstraint?
	private var textViewTrailingConstraint: NSLayoutConstraint?

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
		
		guard let leadingConstraint = textViewLeadingConstraint, let trailingConstraint = textViewTrailingConstraint else {
			return
		}
		let inset = safeAreaInsets.left
		leadingConstraint.constant = inset + 23
		trailingConstraint.constant = -inset - 23
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
		
		let textView = UIView()
		textView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(textView)
		
		textView.addSubview(titleLabel)
		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
			titleLabel.topAnchor.constraint(equalTo: textView.topAnchor),
			titleLabel.bottomAnchor.constraint(equalTo: textView.bottomAnchor),
		])
		
		
		textViewLeadingConstraint = textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23)
		textViewTrailingConstraint = textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23)
		textViewLeadingConstraint?.isActive = true
		textViewTrailingConstraint?.isActive = true
		NSLayoutConstraint.activate([
			textView.topAnchor.constraint(equalTo: topAnchor, constant: 23),
			textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -23),
		])
	}

}

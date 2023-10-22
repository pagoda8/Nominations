//
//  NoNominationsView.swift
//  Nominations
//
//  Created by Wojtek on 22/10/2023.
//

import UIKit

class NoNominationsView: UIView {
	
	private let textLabel: UILabel = {
		let label = UILabel()
		label.text = "Once you submit a nomination, you will be able to see it here.".uppercased()
		label.textAlignment = .center
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 0
		label.textColor = .cubeDarkGrey
		label.font = UIFont.style.boldHeadlineMedium
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let iconImageView: UIImageView = {
		let image = UIImage(systemName: "tray.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 80))
		let imageView = UIImageView(image: image)
		imageView.contentMode = .scaleAspectFit
		imageView.tintColor = .cubeMidGrey
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
	
	private func setup() {
		backgroundColor = .cubeLightGrey
		
		addSubview(iconImageView)
		NSLayoutConstraint.activate([
			iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 70),
		])
		
		let textView = UIView()
		textView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(textView)
		
		textView.addSubview(textLabel)
		NSLayoutConstraint.activate([
			textLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor),
			textLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
			textLabel.topAnchor.constraint(equalTo: textView.topAnchor),
			textLabel.bottomAnchor.constraint(equalTo: textView.bottomAnchor),
		])
		
		NSLayoutConstraint.activate([
			textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
			textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23),
			textView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 40),
			textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -70)
		])
	}

}

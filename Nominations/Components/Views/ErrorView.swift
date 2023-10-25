//
//  ErrorView.swift
//  Nominations
//
//  Created by Wojtek on 23/10/2023.
//

import UIKit

class ErrorView: UIView {
	private var type: ErrorViewType?
	
	private var textLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 0
		label.textColor = .cubeDarkGrey
		label.font = UIFont.style.boldHeadlineMedium
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let iconImageView: UIImageView = {
		let image = UIImage(systemName: "xmark.app.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 80))
		let imageView = UIImageView(image: image)
		imageView.contentMode = .scaleAspectFit
		imageView.tintColor = .cubeMidGrey
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	init(type: ErrorViewType) {
		super.init(frame: .zero)
		self.type = type
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setup() {
		setupText()
		
		addSubview(iconImageView)
		NSLayoutConstraint.activate([
			iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 70),
		])
		
		addSubview(textLabel)
		NSLayoutConstraint.activate([
			textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
			textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23),
			textLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 40),
			textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -70)
		])
	}
	
	private func setupText() {
		switch type {
		case .loginError:
			textLabel.text = "Could not log in. Try again later.".uppercased()
		case .fetchError:
			textLabel.text = "Error while loading nominations. Try again later.".uppercased()
		default:
			textLabel.text = "An error occured. Try again later.".uppercased()
		}
	}
}

enum ErrorViewType {
	case loginError
	case fetchError
}

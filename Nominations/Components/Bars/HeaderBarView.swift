//
//  HeaderBarView.swift
//  Nominations
//
//  Created by Wojtek on 21/10/2023.
//

import UIKit

class HeaderBarView: UIView {
	private var title: String?
	private var contentViewTopConstraint: NSLayoutConstraint?
	
	private let topPadding: CGFloat = 8
	private let padding: CGFloat = 20
	
	init(title: String? = nil) {
		super.init(frame: .zero)
		self.title = title
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		guard let topConstraint = contentViewTopConstraint else {
			return
		}
		let topInset = safeAreaInsets.top
		let extraPadding: CGFloat = UIDevice.current.orientation.isPortrait ? 0 : 12
		topConstraint.constant = topPadding + topInset + extraPadding
	}
	
	private func setup() {
		backgroundColor = .black
		addShadow()
		
		let contentView = UIView()
		contentView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(contentView)
		
		if let title = title {
			let label = UILabel()
			label.text = title
			label.font = UIFont.style.navigationBar
			label.textColor = .white
			label.textAlignment = .center
			label.lineBreakMode = .byWordWrapping
			label.numberOfLines = 0
			label.translatesAutoresizingMaskIntoConstraints = false
			contentView.addSubview(label)
			
			NSLayoutConstraint.activate([
				label.topAnchor.constraint(equalTo: contentView.topAnchor),
				label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
				label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
				label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			])
		}
		else {
			let imageView = UIImageView(image: UIImage.logoIcon)
			imageView.contentMode = .scaleAspectFit
			imageView.tintColor = .white
			imageView.translatesAutoresizingMaskIntoConstraints = false
			contentView.addSubview(imageView)
			
			NSLayoutConstraint.activate([
				imageView.heightAnchor.constraint(equalToConstant: 35),
				imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
				imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
				imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			])
		}
		
		self.contentViewTopConstraint = contentView.topAnchor.constraint(equalTo: topAnchor, constant: topPadding)
		self.contentViewTopConstraint?.isActive = true
		NSLayoutConstraint.activate([
			contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
			contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
		])
	}
	
	private func addShadow() {
		layer.shadowColor = UIColor.shadowStrong.cgColor
		layer.shadowOpacity = 1
		layer.shadowOffset = CGSize(width: 0, height: 2)
		layer.shadowRadius = 10
	}
	
}

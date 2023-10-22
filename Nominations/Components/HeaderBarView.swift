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
		let padding: CGFloat = UIDevice.current.orientation.isPortrait ? 0 : 12
		topConstraint.constant = topInset + padding + 8
	}
	
	private func setup() {
		backgroundColor = .black
		layer.shadowColor = UIColor.shadowStrong.cgColor
		layer.shadowOpacity = 1
		layer.shadowOffset = CGSize(width: 0, height: 2)
		layer.shadowRadius = 10
		
		let contentView = UIView()
		contentView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(contentView)
		
		if let title = title {
			let label = UILabel()
			label.text = title
			label.font = UIFont.style.navigationBar
			label.textColor = .white
			label.translatesAutoresizingMaskIntoConstraints = false
			contentView.addSubview(label)
			
			NSLayoutConstraint.activate([
				label.topAnchor.constraint(equalTo: contentView.topAnchor),
				label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
				label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
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
		
		self.contentViewTopConstraint = contentView.topAnchor.constraint(equalTo: topAnchor, constant: 8)
		self.contentViewTopConstraint?.isActive = true
		NSLayoutConstraint.activate([
			contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
			contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
		])
	}
	
}

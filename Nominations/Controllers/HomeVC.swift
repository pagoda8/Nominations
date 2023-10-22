//
//  HomeVC.swift
//  Nominations
//
//  Created by Wojtek on 21/10/2023.
//

import UIKit

class HomeVC: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	private func setupUI() {
		view.backgroundColor = .cubeLightGrey
		
		let header = HeaderBarView()
		header.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(header)
		
		NSLayoutConstraint.activate([
			header.topAnchor.constraint(equalTo: view.topAnchor),
			header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
	}
}


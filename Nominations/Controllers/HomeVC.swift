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
		view.backgroundColor = .cubeLightGrey
		
		MainManager.logInUser { [weak self] in
			DispatchQueue.main.async {
				self?.setupUI()
			}
		}
	}

	private func setupUI() {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 0
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		let nominationsHeader = NominationsHeaderView()
		stackView.addArrangedSubview(nominationsHeader)
		
		if MainManager.isLoggedIn {
			let noNominationsView = NoNominationsView()
			stackView.addArrangedSubview(noNominationsView)
		}
		else {
			let loginErrorView = LoginErrorView()
			stackView.addArrangedSubview(loginErrorView)
		}
		
		scrollView.addSubview(stackView)
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
		])
		
		view.addSubview(scrollView)
		NSLayoutConstraint.activate([
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
		
		let header = HeaderBarView()
		header.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(header)
		
		NSLayoutConstraint.activate([
			header.topAnchor.constraint(equalTo: view.topAnchor),
			header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			header.bottomAnchor.constraint(equalTo: scrollView.topAnchor),
		])
		
		let footer = FooterBarView()
		footer.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(footer)
		NSLayoutConstraint.activate([
			footer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			footer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			footer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			footer.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
		])
		
		let button = PrimaryButton(title: "Create new nomination")
		button.isEnabled = MainManager.isLoggedIn
		footer.addButton(button)
	}
}


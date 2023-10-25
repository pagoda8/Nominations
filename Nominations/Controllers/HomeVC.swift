//
//  HomeVC.swift
//  Nominations
//
//  Created by Wojtek on 21/10/2023.
//

import UIKit

class HomeVC: UIViewController {
	
	private let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 0
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .cubeLightGrey
		setup()
	}
	
	private func setup() {
		let dispatchGroup = DispatchGroup()
		
		dispatchGroup.enter()
		MainManager.logInUser {
			dispatchGroup.enter()
			MainManager.fetchNominations {
				dispatchGroup.leave()
			}
			dispatchGroup.enter()
			MainManager.fetchNominees {
				dispatchGroup.leave()
			}
			dispatchGroup.leave()
		}
		
		dispatchGroup.notify(queue: .main) { [weak self] in
			self?.setupUI()
		}
	}

	private func setupUI() {
		let scrollView = UIScrollView()
		scrollView.showsVerticalScrollIndicator = false
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		
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
		button.setActionHandler { [weak self] in
			button.isEnabled = false
			self?.createTestNomination() { [weak self] in
				DispatchQueue.main.async {
					self?.setupStackView()
					button.isEnabled = true
				}
			}
		}
		footer.addButton(button)
		
		setupStackView()
	}
	
	private func setupStackView() {
		clearStackView()
		
		let nominationsHeader = NominationsHeaderView()
		stackView.addArrangedSubview(nominationsHeader)
		
		if MainManager.isLoggedIn {
			if let nominations = NominationManager.getNominations(), let nominees = NominationManager.getNominees() {
				if !nominees.isEmpty {
					print("I HAVE NOMINEES")
				}
				if !nominations.isEmpty {
					print("I HAVE NOMINATIONS (\(nominations.count))")
				}
				else {
					let noNominationsView = NoNominationsView()
					stackView.addArrangedSubview(noNominationsView)
				}
			}
			else {
				let fetchErrorView = ErrorView(type: .fetchError)
				stackView.addArrangedSubview(fetchErrorView)
			}
		}
		else {
			let loginErrorView = ErrorView(type: .loginError)
			stackView.addArrangedSubview(loginErrorView)
		}
	}
	
	private func clearStackView() {
		for subview in stackView.arrangedSubviews {
			stackView.removeArrangedSubview(subview)
			subview.removeFromSuperview()
		}
	}
	
	private func createTestNomination(completion: @escaping () -> Void) {
		// Mock data for testing
		guard let nominee = NominationManager.getNominees()?.randomElement() else {
			completion()
			return
		}
		let reason = ["Positive attitude", "Motivates others", "Great work ethic", "Always professional"].randomElement()!
		let process = "very_fair"
		
		let body: [String: String] = [
			"nominee_id": nominee.nomineeID,
			"reason": reason,
			"process": process,
		]
		
		MainManager.createNomination(body: body) {
			completion()
		}
	}
}


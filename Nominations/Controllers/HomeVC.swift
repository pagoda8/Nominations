//
//  HomeVC.swift
//  Nominations
//
//  Created by Wojtek on 21/10/2023.
//
//	Home screen view controller

import UIKit

class HomeVC: UIViewController {
	
	// Vertical stack view showing submitted nominations
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
	
	// Logs in user, fetches nominations and nominees, then sets up UI
	private func setup() {
		let dispatchGroup = DispatchGroup()
		
		dispatchGroup.enter()
		// Switch between registerUser / logInUser functions if needed
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

	// Setup user interface
	private func setupUI() {
		// Scroll view that holds stack view
		let scrollView = UIScrollView()
		scrollView.showsVerticalScrollIndicator = false
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		
		// Embed and setup stack view in scroll view
		scrollView.addSubview(stackView)
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
		])
		
		// Add and setup scroll view
		view.addSubview(scrollView)
		NSLayoutConstraint.activate([
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
		
		// Add and setup header bar
		let header = HeaderBarView()
		header.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(header)
		NSLayoutConstraint.activate([
			header.topAnchor.constraint(equalTo: view.topAnchor),
			header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			header.bottomAnchor.constraint(equalTo: scrollView.topAnchor),
		])
		
		// Add and setup footer bar
		let footer = FooterBarView()
		footer.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(footer)
		NSLayoutConstraint.activate([
			footer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			footer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			footer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			footer.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
		])
		
		// Setup button and add to footer bar
		let button = PrimaryButton(title: "Create new nomination")
		button.isEnabled = MainManager.isLoggedIn
		footer.addButton(button)
		
		// When button is tapped, disable it, create nomination, refresh stack view and re-enable button
		button.setActionHandler { [weak self] in
			button.isEnabled = false
			self?.createTestNomination() { [weak self] in
				DispatchQueue.main.async {
					self?.setupStackView()
					button.isEnabled = true
				}
			}
		}
		
		setupStackView()
	}
	
	// Setup / refresh stack view
	private func setupStackView() {
		clearStackView()
		
		let nominationsHeader = NominationsHeaderView()
		stackView.addArrangedSubview(nominationsHeader)
		
		if MainManager.isLoggedIn {
			if let nominationViews = NominationViewBuilder.createNominationViews() {
				if !nominationViews.isEmpty {
					// Add nomination views to stack view
					for nominationView in nominationViews {
						stackView.addArrangedSubview(nominationView)
					}
				}
				else {
					// If user has no submitted nominations
					let noNominationsView = NoNominationsView()
					stackView.addArrangedSubview(noNominationsView)
				}
			}
			else {
				// If data wasn't fetched from API
				let fetchErrorView = ErrorView(type: .fetchError)
				stackView.addArrangedSubview(fetchErrorView)
			}
		}
		else {
			// If user could not log in
			let loginErrorView = ErrorView(type: .loginError)
			stackView.addArrangedSubview(loginErrorView)
		}
		
		stackView.layoutIfNeeded()
	}
	
	// Remove all elements from stack view
	private func clearStackView() {
		for subview in stackView.arrangedSubviews {
			stackView.removeArrangedSubview(subview)
			subview.removeFromSuperview()
		}
	}
	
	// Creates a test nomination
	private func createTestNomination(completion: @escaping () -> Void) {
		// Pick random nominee
		guard let nominee = NominationManager.getNominees()?.randomElement() else {
			completion()
			return
		}
		// Mock data for testing
		let reason = ["Positive attitude", "Motivates others", "Great work ethic", "Always professional"].randomElement()!
		let process = "very_fair"
		
		let body: [String: String] = [
			"nominee_id": nominee.nomineeID,
			"reason": reason,
			"process": process,
		]
		
		MainManager.createNomination(body: body, completion: completion)
	}
}

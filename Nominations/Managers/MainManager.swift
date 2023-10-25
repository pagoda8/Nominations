//
//  MainManager.swift
//  Nominations
//
//  Created by Wojtek on 23/10/2023.
//
//	Wrapper for interacting with the Cube Academy API

import Foundation

struct MainManager {
	
	// User details
	// Change if needed and use the registerUser / logInUser function in HomeVC accordingly
	private static let userName = "Wojtek"
	private static let email = "wojtek123@yahoo.com"
	private static let password = "cube_academy"
	
	static var isLoggedIn: Bool {
		return CubeAPIManager.isAuthorized
	}
	
	// MARK: - Register
	
	// Registers a user with the API and establishes a secure connection
	static func registerUser(completion: @escaping () -> Void) {
		guard !isLoggedIn else {
			completion()
			return
		}
		
		let body: [String: String] = [
			"name": userName,
			"email": email,
			"password": password,
		]
		
		CubeAPIManager.postRequestMultipart(endpoint: "register", body: body) { result in
			switch result {
			case .success(let data):
				do {
					// Decode and store the auth token from the API response
					let response = try JSONDecoder().decode(LoginResponse.self, from: data)
					let token = response.data.authToken
					CubeAPIManager.setAuthToken(token)
					completion()
				} catch {
					print("Error while decoding JSON data (registration).")
					completion()
				}
			case .failure(let error):
				print("Could not register user. Error: \(error)")
				completion()
			}
		}
	}
	
	// MARK: - Login
	
	// Logs in a user and establishes a secure connection with API
	static func logInUser(completion: @escaping () -> Void) {
		guard !isLoggedIn else {
			completion()
			return
		}
		
		let body: [String: String] = [
			"email": email,
			"password": password,
		]
		
		CubeAPIManager.postRequestMultipart(endpoint: "login", body: body) { result in
			switch result {
			case .success(let data):
				do {
					// Decode and store the auth token from the API response
					let response = try JSONDecoder().decode(LoginResponse.self, from: data)
					let token = response.data.authToken
					CubeAPIManager.setAuthToken(token)
					completion()
				} catch {
					print("Error while decoding JSON data (login).")
					completion()
				}
			case .failure(let error):
				print("Could not log in user. Error: \(error)")
				completion()
			}
		}
	}
	
	// MARK: - Fetch nominations
	
	// Fetches user's submitted nominations from API
	static func fetchNominations(completion: @escaping () -> Void) {
		guard isLoggedIn else {
			completion()
			return
		}
		
		CubeAPIManager.getRequest(endpoint: "nomination") { result in
			switch result {
			case .success(let data):
				do {
					// Decode and store nominations from API response
					let response = try JSONDecoder().decode(NominationsResponse.self, from: data)
					let nominations = response.data
					NominationManager.setNominations(to: nominations)
					completion()
				} catch {
					print("Error while decoding JSON data (nominations).")
					NominationManager.setNominations(to: nil)
					completion()
				}
			case .failure(let error):
				print("Could not fetch nominations. Error: \(error)")
				NominationManager.setNominations(to: nil)
				completion()
			}
		}
	}
	
	// MARK: - Fetch nominees
	
	// Fetches all nominees from API
	static func fetchNominees(completion: @escaping () -> Void) {
		guard isLoggedIn else {
			completion()
			return
		}
		
		CubeAPIManager.getRequest(endpoint: "nominee") { result in
			switch result {
			case .success(let data):
				do {
					// Decode and store nominees from API response
					let response = try JSONDecoder().decode(NomineesResponse.self, from: data)
					let nominees = response.data
					NominationManager.setNominees(to: nominees)
					completion()
				} catch {
					print("Error while decoding JSON data (nominees).")
					NominationManager.setNominees(to: nil)
					completion()
				}
			case .failure(let error):
				print("Could not fetch nominees. Error: \(error)")
				NominationManager.setNominees(to: nil)
				completion()
			}
		}
	}
	
	// MARK: - Create nomination
	
	// Creates and submits a nomination using the API
	static func createNomination(body: [String: String], completion: @escaping () -> Void) {
		guard isLoggedIn else {
			completion()
			return
		}
		
		do {
			// Create JSON data from body dictionary
			let jsonData = try JSONSerialization.data(withJSONObject: body)
			CubeAPIManager.postRequest(endpoint: "nomination", body: jsonData) { result in
				switch result {
				case .success(let data):
					do {
						// Decode and store created nomination from API response
						let response = try JSONDecoder().decode(NominationResponse.self, from: data)
						let nomination = response.data
						NominationManager.addNomination(nomination)
						completion()
					} catch {
						print("Error while decoding JSON data (nomination).")
						completion()
					}
				case .failure(let error):
					print("Could not create nomination. Error: \(error)")
					completion()
				}
			}
		} catch {
			print("Error while creating JSON data (nomination).")
			completion()
		}
	}
}

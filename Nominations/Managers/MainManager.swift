//
//  MainManager.swift
//  Nominations
//
//  Created by Wojtek on 23/10/2023.
//

import Foundation

struct MainManager {
	
	private static let userName = "Wojtek"
	private static let email = "wojtek123@yahoo.com"
	private static let password = "cube_academy"
	
	static var isLoggedIn: Bool {
		return CubeAPIManager.isAuthorized
	}
	
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
	
	static func fetchNominations(completion: @escaping () -> Void) {
		guard isLoggedIn else {
			completion()
			return
		}
		
		CubeAPIManager.getRequest(endpoint: "nomination") { result in
			switch result {
			case .success(let data):
				do {
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
	
	static func fetchNominees(completion: @escaping () -> Void) {
		guard isLoggedIn else {
			completion()
			return
		}
		
		CubeAPIManager.getRequest(endpoint: "nominee") { result in
			switch result {
			case .success(let data):
				do {
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
	
	static func createNomination(body: [String: String], completion: @escaping () -> Void) {
		guard isLoggedIn else {
			completion()
			return
		}
		
		do {
			let jsonData = try JSONSerialization.data(withJSONObject: body)
			CubeAPIManager.postRequest(endpoint: "nomination", body: jsonData) { result in
				switch result {
				case .success(let data):
					do {
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

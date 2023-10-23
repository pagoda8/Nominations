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
		
		let bodyDictionary: [String: String] = [
			"name": userName,
			"email": email,
			"password": password,
		]
		
		do {
			let jsonData = try JSONSerialization.data(withJSONObject: bodyDictionary)
			CubeAPIManager.postRequestMultipart(endpoint: "register", body: jsonData) { result in
				switch result {
				case .success(let data):
					do {
						let response = try JSONDecoder().decode(LoginResponse.self, from: data)
						let token = response.data.authToken
						CubeAPIManager.setAuthToken(token)
						completion()
					} catch {
						print("Error while decoding JSON data.")
						completion()
					}
				case .failure(let error):
					print("Could not register user. Error: \(error)")
					completion()
				}
			}
		} catch {
			print("Error while creating JSON data.")
			completion()
		}
	}
	
	static func logInUser(completion: @escaping () -> Void) {
		guard !isLoggedIn else {
			completion()
			return
		}
		
		let bodyDictionary: [String: String] = [
			"email": email,
			"password": password,
		]
		
		do {
			let jsonData = try JSONSerialization.data(withJSONObject: bodyDictionary)
			CubeAPIManager.postRequestMultipart(endpoint: "login", body: jsonData) { result in
				switch result {
				case .success(let data):
					do {
						let response = try JSONDecoder().decode(LoginResponse.self, from: data)
						let token = response.data.authToken
						CubeAPIManager.setAuthToken(token)
						completion()
					} catch {
						print("Error while decoding JSON data.")
						completion()
					}
				case .failure(let error):
					print("Could not log in user. Error: \(error)")
					completion()
				}
			}
		} catch {
			print("Error while creating JSON data.")
			completion()
		}
	}
}

struct LoginResponse: Decodable {
	let data: LoginDataContainer
}
struct LoginDataContainer: Decodable {
	let authToken: String
}

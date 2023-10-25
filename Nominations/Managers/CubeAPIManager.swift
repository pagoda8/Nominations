//
//  CubeAPIManager.swift
//  Nominations
//
//  Created by Wojtek on 23/10/2023.
//

import Foundation
import Alamofire

struct CubeAPIManager {
	
	// Base URL of the REST API
	private static let baseURL: String = "https://cube-academy-api.cubeapis.com/api/"
	
	private static var authToken: String?
	
	static func setAuthToken(_ token: String) {
		authToken = token
	}
	
	static var isAuthorized: Bool {
		return authToken != nil
	}
	
	private static func createRequest(withEndpoint endpoint: String, method: String, body: Data? = nil) -> URLRequest? {
		guard let url = URL(string: baseURL + endpoint) else {
			return nil
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = method
		
		// Add Bearer token to the authorization header
		if let bearerToken = authToken {
			request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
		}
		
		// Set the request body if applicable
		request.httpBody = body
		
		return request
	}
	
	private static func sendRequest(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
		URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completion(.failure(error))
				return
			}
			guard let data = data else {
				completion(.failure(APIError.noData))
				return
			}
			
			if let httpResponse = response as? HTTPURLResponse {
				if httpResponse.statusCode == 200 {
					completion(.success(data))
				}
				else if httpResponse.statusCode == 201 {
					completion(.success(data))
				}
				else {
					completion(.failure(APIError.httpError(statusCode: httpResponse.statusCode)))
				}
			}
			else {
				completion(.failure(APIError.invalidResponse))
			}
		}.resume()
	}
	
	// MARK: - Public Methods
	
	static func getRequest(endpoint: String, completion: @escaping (Result<Data, Error>) -> Void) {
		guard let request = createRequest(withEndpoint: endpoint, method: "GET") else {
			completion(.failure(APIError.invalidURL))
			return
		}
		
		sendRequest(request: request, completion: completion)
	}
	
	static func postRequest(endpoint: String, body: Data, completion: @escaping (Result<Data, Error>) -> Void) {
		guard let request = createRequest(withEndpoint: endpoint, method: "POST", body: body) else {
			completion(.failure(APIError.invalidURL))
			return
		}
		
		sendRequest(request: request, completion: completion)
	}
	
	static func postRequestMultipart(endpoint: String, body: [String: String], completion: @escaping (Result<Data, Error>) -> Void) {
		AF.upload(multipartFormData: { multipartFormData in
			for entry in body {
				guard let data = entry.value.data(using: .utf8) else {
					completion(.failure(APIError.invalidData))
					return
				}
				multipartFormData.append(data, withName: entry.key)
			}
		}, to: baseURL + endpoint, method: .post, headers: ["Content-Type": "multipart/form-data"])
		.responseData { response in
			if let error = response.error {
				completion(.failure(error))
				return
			}
			guard let data = response.data else {
				completion(.failure(APIError.noData))
				return
			}
			
			if let httpResponse = response.response {
				if httpResponse.statusCode == 200 {
					completion(.success(data))
				}
				else if httpResponse.statusCode == 401 {
					do {
						let apiResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
						let error = apiResponse.data.error
						completion(.failure(APIError.responseError(error)))
					} catch {
						completion(.failure(APIError.responseError("Could not parse error string.")))
					}
				}
				else {
					completion(.failure(APIError.httpError(statusCode: httpResponse.statusCode)))
				}
			}
			else {
				completion(.failure(APIError.invalidResponse))
			}
		}
	}
}

struct ErrorResponse: Decodable {
	let data: ErrorDataContainer
}
struct ErrorDataContainer: Decodable {
	let error: String
}

// Enum for API-related errors
enum APIError: Error {
	case invalidURL
	case noData
	case invalidData
	case responseError(String)
	case httpError(statusCode: Int)
	case invalidResponse
}

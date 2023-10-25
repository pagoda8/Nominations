//
//  JSONModels.swift
//  Nominations
//
//  Created by Wojtek on 25/10/2023.
//
//	Defines models for JSON data returned from API

import Foundation

// MARK: - Error

struct ErrorResponse: Decodable {
	let data: ErrorDataContainer
}
struct ErrorDataContainer: Decodable {
	let error: String
}

// MARK: - Login

struct LoginResponse: Decodable {
	let data: LoginDataContainer
}
struct LoginDataContainer: Decodable {
	let authToken: String
}

// MARK: - Nominations

struct NominationsResponse: Decodable {
	let data: [NominationDataContainer]
}
struct NominationResponse: Decodable {
	let data: NominationDataContainer
}
struct NominationDataContainer: Decodable {
	let nominationID: String
	let nomineeID: String
	let reason: String
	let process: String
	let dateSubmitted: String
	let closingDate: String
	
	enum CodingKeys: String, CodingKey {
		case nominationID = "nomination_id"
		case nomineeID = "nominee_id"
		case reason
		case process
		case dateSubmitted = "date_submitted"
		case closingDate = "closing_date"
	}
}

// MARK: - Nominees

struct NomineesResponse: Decodable {
	let data: [NomineeDataContainer]
}
struct NomineeDataContainer: Decodable {
	let nomineeID: String
	let firstName: String
	let lastName: String
	
	enum CodingKeys: String, CodingKey {
		case nomineeID = "nominee_id"
		case firstName = "first_name"
		case lastName = "last_name"
	}
}

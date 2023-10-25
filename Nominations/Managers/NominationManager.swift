//
//  NominationManager.swift
//  Nominations
//
//  Created by Wojtek on 24/10/2023.
//

import Foundation

struct NominationManager {
	private static var nominations: [Nomination]?
	private static var nominees: [Nominee]?
	
	static func setNominations(to nominations: [Nomination]?) {
		/*let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = ""
		
		let sortedNominations = nominations.sorted { nomination1, nomination2 in
			
		} */
		self.nominations = nominations
	}
	
	static func getNominations() -> [Nomination]? {
		return nominations
	}
	
	static func addNomination(_ nomination: Nomination) {
		if nominations == nil {
			nominations = []
		}
		nominations?.append(nomination)
	}
	
	static func setNominees(to nominees: [Nominee]?) {
		self.nominees = nominees
	}
	
	static func getNominees() -> [Nominee]? {
		return nominees
	}
}

typealias Nomination = NominationDataContainer
typealias Nominee = NomineeDataContainer

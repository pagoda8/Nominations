//
//  NominationManager.swift
//  Nominations
//
//  Created by Wojtek on 24/10/2023.
//
//	Stores nominations and nominees

import Foundation

struct NominationManager {
	
	private static var nominations: [Nomination]?
	private static var nominees: [Nominee]?
	
	static func setNominations(to nominations: [Nomination]?) {
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
	
	static func getNominee(withID id: String) -> Nominee? {
		guard let nominees = nominees else {
			return nil
		}
		for nominee in nominees {
			if nominee.nomineeID == id {
				return nominee
			}
		}
		return nil
	}
	
	static func hasNominees() -> Bool {
		return nominees != nil
	}
}

typealias Nomination = NominationDataContainer
typealias Nominee = NomineeDataContainer

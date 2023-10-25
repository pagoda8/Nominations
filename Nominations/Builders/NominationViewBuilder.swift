//
//  NominationViewBuilder.swift
//  Nominations
//
//  Created by Wojtek on 25/10/2023.
//
//	Creates NominationView objects

import Foundation

struct NominationViewBuilder {
	
	// Returns array with nomination views or nil if nominations weren't fetched
	static func createNominationViews() -> [NominationView]? {
		guard let nominations = NominationManager.getNominations(), NominationManager.hasNominees() else {
			return nil
		}
		
		var nominationViews: [NominationView] = []
		for nomination in nominations {
			if let nominee = NominationManager.getNominee(withID: nomination.nomineeID) {
				let nomineeName = nominee.firstName + " " + nominee.lastName
				let nominationView = NominationView(nomineeName: nomineeName, reason: nomination.reason)
				nominationViews.append(nominationView)
			}
		}
		return nominationViews
	}
}

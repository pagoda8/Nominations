//
//  Font.swift
//  Nominations
//
//  Created by Wojtek on 21/10/2023.
//

import Foundation
import UIKit

extension UIFont {
	static let style = FontStyle()
}

struct FontStyle {
	let navigationBar = UIFont(name: FontName.poppinsMedium, size: 16)
	let button = UIFont(name: FontName.poppinsBold, size: 14)
	
	let boldHeadlineLarge = UIFont(name: FontName.poppinsBold, size: 32)
	let boldHeadlineMedium = UIFont(name: FontName.poppinsBold, size: 24)
	let boldHeadlineSmall = UIFont(name: FontName.poppinsBold, size: 18)
	
	let body = UIFont(name: FontName.anonymousProRegular, size: 16)
	let bodyBold = UIFont(name: FontName.anonymousProBold, size: 16)
}

struct FontName {
	static let anonymousProRegular = "AnonymousPro-Regular"
	static let anonymousProBold = "AnonymousPro-Bold"
	static let poppinsMedium = "Poppins-Medium"
	static let poppinsBold = "Poppins-Bold"
}

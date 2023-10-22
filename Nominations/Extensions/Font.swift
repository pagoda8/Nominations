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
}

struct FontName {
	static let anonymousProRegular = "AnonymousPro-Regular"
	static let anonymousProBold = "AnonymousPro-Bold"
	static let poppinsMedium = "Poppins-Medium"
	static let poppinsBold = "Poppins-Bold"
}
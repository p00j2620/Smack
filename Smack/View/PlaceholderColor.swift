//
//  PlaceholderColor.swift
//  Smack
//
//  Created by Arthur Pujols on 8/13/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import UIKit

class PlaceholderColor: UITextField {
	
	override func awakeFromNib() {
		setupView()
	}
	
	func setupView() {
		self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setupView()
	}

}

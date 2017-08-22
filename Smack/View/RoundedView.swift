//
//  RoundedView.swift
//  Smack
//
//  Created by Arthur Pujols on 8/22/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import UIKit
@IBDesignable
class RoundedView: UIView {

	override func awakeFromNib() {
		setupView()
	}
	
	func setupView() {
		self.layer.cornerRadius = 5.0
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setupView()
	}

}

//
//  CircleUIImage.swift
//  Smack
//
//  Created by Arthur Pujols on 8/11/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import UIKit
@IBDesignable
class CircleUIImage: UIImageView {
	override func awakeFromNib() {
		setUpView()
	}
	
	func setUpView() {
		self.layer.cornerRadius = self.frame.width / 2
		self.clipsToBounds = true
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setUpView()
	}

}

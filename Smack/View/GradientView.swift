//
//  GradientView.swift
//  Smack
//
//  Created by Arthur Pujols on 8/1/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import UIKit
@IBDesignable
// Class to add gradient to VC backround
class GradientView: UIView {
	
	// Variables to represent the top and bottom colors of gradient
	@IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1) {
		didSet {
			self.setNeedsLayout()
		}
	}
	
	@IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
		didSet {
			self.setNeedsLayout()
		}
	}
	
	// Function to set color, start/end point of layer view, and set frame size to gradient layer
	override func layoutSubviews() {
		let gradientLayer = CAGradientLayer()
		
		gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
		gradientLayer.startPoint = CGPoint(x: 0, y: 0)
		gradientLayer.endPoint = CGPoint(x: 1, y: 1)
		gradientLayer.frame = self.bounds
		// Inserting subview to VC layer
		self.layer.insertSublayer(gradientLayer, at: 0)
	}
}

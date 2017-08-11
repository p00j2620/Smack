//
//  AvatarCell.swift
//  Smack
//
//  Created by Arthur Pujols on 8/9/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import UIKit

	// Enums
enum AvatarType {
	case dark
	case light
}
class AvatarCell: UICollectionViewCell {
	
    
	@IBOutlet weak var avatarImg: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setUpView()
	}
	
	
	
	// Functions
	func configureCell(index: Int, type: AvatarType) {
		if type == AvatarType.dark {
			avatarImg.image = UIImage(named: "dark\(index)")
			self.layer.backgroundColor = UIColor.lightGray.cgColor
		} else {
			avatarImg.image = UIImage(named: "light\(index)")
			self.layer.backgroundColor = UIColor.gray.cgColor
		}
	}
	
	func setUpView() {
		self.layer.cornerRadius = 10
		self.layer.backgroundColor = UIColor.lightGray.cgColor
		self.clipsToBounds = true
	}
	
}

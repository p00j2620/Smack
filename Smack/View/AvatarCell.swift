//
//  AvatarCell.swift
//  Smack
//
//  Created by Arthur Pujols on 8/9/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import UIKit
@IBDesignable
class AvatarCell: UICollectionViewCell {
    
	@IBOutlet weak var avatarImg: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setUpView()
	}
	
	func setUpView() {
		self.layer.cornerRadius = 10
		self.layer.backgroundColor = UIColor.lightGray.cgColor
		self.clipsToBounds = true
		
		
	}
	
}

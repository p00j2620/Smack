//
//  MessageCell.swift
//  Smack
//
//  Created by Arthur Pujols on 8/22/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
	
	// Outlets
	@IBOutlet weak var avatarImage: CircleUIImage!
	@IBOutlet weak var usernameTextLabel: UILabel!
	@IBOutlet weak var timeStampLabel: UILabel!
	@IBOutlet weak var messageBodyLabel: UILabel!
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
		
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

		if selected {
			self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
		} else {
			self.layer.backgroundColor = UIColor.clear.cgColor
			
		}
    }
	
	func configureCell(message: Message) {
		
		avatarImage.image = UIImage(named: message.userAvatar)
		avatarImage.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
		usernameTextLabel.text = message.username ?? ""
		messageBodyLabel.text = message.message ?? ""
	}

}

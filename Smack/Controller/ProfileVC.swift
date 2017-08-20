//
//  ProfileVCViewController.swift
//  Smack
//
//  Created by Arthur Pujols on 8/15/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
	
	// Outlets
	
	@IBOutlet weak var bgImage: UIView!
	@IBOutlet weak var userAvatarImage: CircleUIImage!
	@IBOutlet weak var usernameLabel: UILabel!
	@IBOutlet weak var emailLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupView()

       
    }


	// Actions
	@IBAction func closeButtonTapped(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	@IBAction func logoutButtonTapped(_ sender: UIButton) {
		UserDataService.instance.logoutUser()
		NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
		dismiss(animated: true, completion: nil)
	}
	
	
	
	// Functions
	func setupView() {
		
		userAvatarImage.image = UIImage(named: UserDataService.instance.avatarName)
		userAvatarImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
		usernameLabel.text = UserDataService.instance.name
		emailLabel.text = UserDataService.instance.email
		
		let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
		bgImage.addGestureRecognizer(closeTouch)

		
		}
	
	@objc func closeTap(_ recognizer: UITapGestureRecognizer) {
		dismiss(animated: true, completion: nil)
	}
}

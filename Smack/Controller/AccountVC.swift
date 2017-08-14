//
//  AccountVC.swift
//  Smack
//
//  Created by Arthur Pujols on 8/1/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import UIKit

class AccountVC: UIViewController {
	// Outlets
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var avatarBtnImage: UIButton!
	
	@IBOutlet weak var spinner: UIActivityIndicatorView!
	
	
	// Variables
	var avatarName = "profileDefault"
	var avatarColor = "[0.5, 0.5, 0.5, 1]"
	var bgColor : UIColor?
	
	// View Did Load
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.dismissKeyboardOnTap()
		setupView()
    }
	
	// Functions
	override func viewDidAppear(_ animated: Bool) {
		if UserDataService.instance.avatarName != "" {
			if let userAvatar = UIImage(named: UserDataService.instance.avatarName){
				avatarBtnImage.setImage(userAvatar, for: .normal)
				avatarName = UserDataService.instance.avatarName
				if avatarName.contains("light") && bgColor == nil {
					avatarBtnImage.backgroundColor = UIColor.lightGray
				}
			}
			
		}
	}
	
	func setupView() {
		
		spinner.isHidden = true
//		usernameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
//		emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
//		passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
	}
	
	@IBAction func avatarImgBtnTapped(_ sender: UIButton) {
		performSegue(withIdentifier: TO_AVATAR_PICKERVC, sender: nil)
	}
	
	@IBAction func closeBtnTapped(_ sender: UIButton) {
		performSegue(withIdentifier: UNWIND_TO_CHANNELVC, sender: nil)
	}
	@IBAction func chooseAvatarTapped(_ sender: UIButton) {
		performSegue(withIdentifier: TO_AVATAR_PICKERVC, sender: nil)
	}
	@IBAction func generateRandomColorTapped(_ sender: UIButton) {
		let r = CGFloat(arc4random_uniform(255)) / 255
		let g = CGFloat(arc4random_uniform(255)) / 255
		let b = CGFloat(arc4random_uniform(255)) / 255
		
		bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
		UIView.animate(withDuration: 0.2) {
			self.avatarBtnImage.backgroundColor = self.bgColor
		}
		
	}
	@IBAction func createAccountButtonTapped(_ sender: UIButton) {
		
		spinner.isHidden = false
		spinner.startAnimating()
		
		guard let username = usernameTextField.text , usernameTextField.text != "" else {
			return
		}
		
		guard let email = emailTextField.text , emailTextField.text != "" else {
			return
		}
		guard let pass = passwordTextField.text, passwordTextField.text != "" else {
			return
		}
		AuthService.instance.registerUser(email: email, password: pass) { (success) in
			if success {
				AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
					if success {
						AuthService.instance.createUser(name: username, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
							if success {
								self.spinner.isHidden = true
								self.spinner.stopAnimating()
								self.performSegue(withIdentifier: UNWIND_TO_CHANNELVC, sender: nil)
								NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
							}
						})
					}
				})
			}
		}
	}
	
}

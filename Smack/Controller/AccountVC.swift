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
	
	
	
	// Variables
	var avatarName = "profileDefault"
	var avatarColor = "[0.5, 0.5, 0.5, 1]"
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.dismissKeyboardOnTap()

		
    }
	// Functions
	override func viewDidAppear(_ animated: Bool) {
		if UserDataService.instance.avatarName != "" {
			if let userAvatar = UIImage(named: UserDataService.instance.avatarName){
				avatarBtnImage.setImage(userAvatar, for: .normal)
			}
			avatarName = UserDataService.instance.avatarName
		}
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
	}
	@IBAction func createAccountButtonTapped(_ sender: UIButton) {
		
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
								print(UserDataService.instance.name, UserDataService.instance.avatarName)
								self.performSegue(withIdentifier: UNWIND_TO_CHANNELVC, sender: nil)
							}
						})
					}
				})
			}
		}
	}
	
}

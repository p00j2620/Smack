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
	@IBOutlet weak var avatarImage: UIImageView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.dismissKeyboardOnTap()

		
    }
	// Functions
	
	@IBAction func closeBtnTapped(_ sender: UIButton) {
		performSegue(withIdentifier: UNWIND_TO_CHANNELVC, sender: nil)
	}
	@IBAction func chooseAvatarTapped(_ sender: UIButton) {
	}
	@IBAction func generateRandomColorTapped(_ sender: UIButton) {
	}
	@IBAction func createAccountButtonTapped(_ sender: UIButton) {
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
						print("User is logged in", AuthService.instance.authToken)
					}
				})
			}
		}
	}
	
}

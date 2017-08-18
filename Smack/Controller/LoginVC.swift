//
//  LoginVC.swift
//  Smack
//
//  Created by Arthur Pujols on 8/1/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
	// Outlets
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	@IBOutlet weak var spinner: UIActivityIndicatorView!
	
	// View Did Load
	override func viewDidLoad() {
		super.viewDidLoad()
		self.dismissKeyboardOnTap()
		setupView()
	}
	
	// Actions
	@IBAction func closeBtnTapped(_ sender: UIButton) {
		// Dismisses loginVC when tapped
		dismiss(animated: true, completion: nil)
	}
	@IBAction func loginBtnTapped(_ sender: UIButton) {
		spinner.isHidden = false
		spinner.startAnimating()
		
		guard let email = usernameTextField.text, usernameTextField.text != "" else { return }
		guard let password = passwordTextField.text, passwordTextField.text != "" else { return }
		
		AuthService.instance.loginUser(email: email, password: password) { (success) in
			if success {
				AuthService.instance.findUserByEmail(completion: { (success) in
					if success {
						NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
						self.spinner.isHidden = true
						self.spinner.stopAnimating()
						self.dismiss(animated: true, completion: nil)
					}
				})
			}
		}
	}
	
	@IBAction func signupBtnTapped(_ sender: Any) {
		performSegue(withIdentifier: TO_ACCOUNT, sender: nil)
	}
	
	// Functions
	func setupView() {
		self.spinner.isHidden = true
	}
}

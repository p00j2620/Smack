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
	
	
	// View Did Load
	override func viewDidLoad() {
		super.viewDidLoad()
		self.dismissKeyboardOnTap()
//		setupView()
	}
	
	// Actions
	@IBAction func closeBtnTapped(_ sender: UIButton) {
		// Dismisses loginVC when tapped
		dismiss(animated: true, completion: nil)
	}
	@IBAction func loginBtnTapped(_ sender: UIButton) {
		
	}
	
	@IBAction func signupBtnTapped(_ sender: Any) {
		performSegue(withIdentifier: TO_ACCOUNT, sender: nil)
	}
	
	// Functions
//	func setupView() {
//
//		usernameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
//
//		passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
//	}
	
}

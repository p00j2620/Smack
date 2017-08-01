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
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
	}

	// Functions
	@IBAction func closeBtnTapped(_ sender: UIButton) {
		// Dismisses loginVC when tapped
		dismiss(animated: true, completion: nil)
	}
	@IBAction func loginBtnTapped(_ sender: UIButton) {
	}
	@IBOutlet weak var signupBtnTapped: UIButton!
	
}

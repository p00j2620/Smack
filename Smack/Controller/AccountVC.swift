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
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.dismissKeyboardOnTap()

		
    }
	// Functions
	
	@IBAction func closeBtnTapped(_ sender: UIButton) {
		performSegue(withIdentifier: UNWIND_TO_CHANNELVC, sender: nil)
	}
	
}

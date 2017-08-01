//
//  ChannelVC.swift
//  Smack
//
//  Created by Arthur Pujols on 8/1/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import UIKit
// This VC controls the front view in SWReveal
class ChannelVC: UIViewController {
	
	//Outlets
	@IBOutlet weak var loginBtn: UIButton!
	

    override func viewDidLoad() {
        super.viewDidLoad()
		self.dismissKeyboardOnTap()
		
		// Setting the width of revealed window - ChatVC
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 48
    }
	// Functions
	
	@IBAction func loginBtnTapped(_ sender: UIButton) {
		performSegue(withIdentifier: TO_LOGIN, sender: nil)
	}
	@IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
	
}

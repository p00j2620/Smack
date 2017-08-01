//
//  ChatVC.swift
//  Smack
//
//  Created by Arthur Pujols on 8/1/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import UIKit
// This VC Controls the rear view in SWReveal
class ChatVC: UIViewController {
	
	//Outlets
	@IBOutlet weak var menuBtn: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.dismissKeyboardOnTap()
		
		// Added action on button press and implemented swipe gesture to reveal ChatVC and tap to close
		menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
		self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
		self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())

		
    }
 // Functions
}

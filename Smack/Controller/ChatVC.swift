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
		
		if AuthService.instance.isLoggedin {
			AuthService.instance.findUserByEmail(completion: { (success) in
				NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
			})
		}

		MessageService.instance.findAllChannel(completion: { (success) in
			
		})
    }
 // Functions
	
}

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
	@IBOutlet weak var channelNameLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.dismissKeyboardOnTap()
		
		NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
		
		// Added action on button press and implemented swipe gesture to reveal ChatVC and tap to close
		menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
		self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
		self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
		
		if AuthService.instance.isLoggedin {
			AuthService.instance.findUserByEmail(completion: { (success) in
				NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
			})
		}

    }
 // Functions
	@objc func userDataDidChange(_ notif: Notification) {
		if AuthService.instance.isLoggedin {
			onLoginGetMessages()
		} else {
			channelNameLabel.text = "Please Log In"
		}
	}
	
	@objc func channelSelected(_ notif: Notification) {
		updateWithChannel()
	}
	
	func updateWithChannel() {
		let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
		channelNameLabel.text = "#\(channelName)"
	}
	
	func onLoginGetMessages() {
		MessageService.instance.findAllChannel { (success) in
			if success {
				// Do stuff with channels
			}
		}
	}
}

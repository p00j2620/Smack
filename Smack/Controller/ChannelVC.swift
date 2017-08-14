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
	@IBOutlet weak var avatarImage: CircleUIImage!
	

    override func viewDidLoad() {
        super.viewDidLoad()
		self.dismissKeyboardOnTap()
		NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
		// Setting the width of revealed window - ChatVC
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 48
    }
	// Functions
	
	@IBAction func loginBtnTapped(_ sender: UIButton) {
		performSegue(withIdentifier: TO_LOGIN, sender: nil)
	}
	@IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
	
	@objc func userDataDidChange(_ notif: Notification) {
		if AuthService.instance.isLoggedin {
			loginBtn.setTitle(UserDataService.instance.name, for: .normal)
			avatarImage.image = UIImage(named: UserDataService.instance.avatarName)
			avatarImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
			
		} else {
			loginBtn.setTitle("Login", for: .normal)
			avatarImage.image = UIImage(named: "menuProfileIcon")
			avatarImage.backgroundColor = UIColor.clear
		}
	}
}

//
//  ChannelVC.swift
//  Smack
//
//  Created by Arthur Pujols on 8/1/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import UIKit
// This VC controls the front view in SWReveal
class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	//Outlets
	@IBOutlet weak var loginBtn: UIButton!
	@IBOutlet weak var avatarImage: CircleUIImage!
	@IBOutlet weak var tableView: UITableView!
	

    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		self.dismissKeyboardOnTap()
		NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
		// Setting the width of revealed window - ChatVC
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 48
    }
	// Functions
	
	@IBAction func loginBtnTapped(_ sender: UIButton) {
		if AuthService.instance.isLoggedin {
			let profile = ProfileVC()
			profile.modalPresentationStyle = .custom
			present(profile, animated: true, completion: nil)
		} else {
			performSegue(withIdentifier: TO_LOGIN, sender: nil)
		}
		
		
	}
	@IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
	
	@IBAction func addChannelButtonTapped(_ sender: UIButton) {
		if AuthService.instance.isLoggedin {
			let addChannelForm = AddChannelVC()
			addChannelForm.modalPresentationStyle = .custom
			present(addChannelForm, animated: true, completion: nil)
		} else {
			performSegue(withIdentifier: TO_LOGIN, sender: nil)
		}
	}
	@objc func userDataDidChange(_ notif: Notification) {
		setupUserInfo()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		setupUserInfo()
	}
	
	func setupUserInfo() {
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
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
			let channel = MessageService.instance.channels[indexPath.row]
			cell.configureCell(channel: channel)
			return cell
		} else {
			return UITableViewCell()
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return MessageService.instance.channels.count
	}
	
	
	
}

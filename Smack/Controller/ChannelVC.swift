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
		socketOnReloadTableView()
		NotificationCenter.default.addObserver(self, selector: #selector(channelsLoaded), name: NOTIF_CHANNELS_LOADED, object: nil)
	
		getNewChannelMessages()

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
	
	@objc func channelsLoaded() {
		tableView.reloadData()
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
			tableView.reloadData()
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
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let channel = MessageService.instance.channels[indexPath.row]
		MessageService.instance.selectedChannel = channel
		MessageService.instance.messages.removeAll()
		NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
		self.revealViewController().revealToggle(animated: true)
	
		if MessageService.instance.unreadChannels.count > 0 {
			MessageService.instance.unreadChannels = MessageService.instance.unreadChannels.filter{$0 != channel.id}
		}
		
		let index = IndexPath(row: indexPath.row, section: 0)
		tableView.reloadRows(at: [index], with: .none)
		tableView.selectRow(at: index, animated: false, scrollPosition: .none)
		self.tableView.reloadData()
	}
	
	func socketOnReloadTableView() {
		SocketService.instance.getChannel { (success) in
			if success {
				self.tableView.reloadData()
			}
		}
	}
	
	func getNewChannelMessages() {
		
		SocketService.instance.getMessage { (newMessage) in
			let channelId = MessageService.instance.selectedChannel?.id
			if newMessage.channelId != channelId && AuthService.instance.isLoggedin {
				MessageService.instance.unreadChannels.append(newMessage.channelId)
				self.tableView.reloadData()
			}
		}
		
	}
	
	

	
}

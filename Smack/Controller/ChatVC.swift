//
//  ChatVC.swift
//  Smack
//
//  Created by Arthur Pujols on 8/1/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import UIKit
// This VC Controls the rear view in SWReveal
class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	
	
	//Outlets
	@IBOutlet weak var menuBtn: UIButton!
	@IBOutlet weak var channelNameLabel: UILabel!
	@IBOutlet weak var messageTextField: UITextField!
	@IBOutlet weak var typingUserLabel: UILabel!
	
	@IBOutlet weak var messageTableView: UITableView!
	@IBOutlet weak var sendMessageButton: UIButton!
	
	// Variables
	
	var isTyping = false
	
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//		self.dismissKeyboardOnTap()
		view.bindToKeyboard()
		messageTableView.delegate = self
		messageTableView.dataSource = self
		socketOnReloadData()
		
		self.messageTableView.estimatedRowHeight = 80
		self.messageTableView.rowHeight = UITableViewAutomaticDimension
		sendMessageButton.isHidden = true
		
		
		NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.newMessage(_:)), name: NOTIF_NEW_MESSAGE, object: nil)
		
		// Added action on button press and implemented swipe gesture to reveal ChatVC and tap to close
		menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
		self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
		self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
		
		if AuthService.instance.isLoggedin {
			AuthService.instance.findUserByEmail(completion: { (success) in
				NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
			})
		}
		
		SocketService.instance.getTypingUsers { (typingUsers) in
			guard let channelId = MessageService.instance.selectedChannel?.id else { return }
			var names = ""
			var numberOfTypers = 0
			
			for (typingUser, channel) in typingUsers {
				if typingUser != UserDataService.instance.name && channelId == channel {
					if names == "" {
						names = typingUser
					} else {
						names = "\(names), \(typingUser)"
					}
					numberOfTypers += 1
				}
				
				if numberOfTypers > 0 && AuthService.instance.isLoggedin {
					var verb = "is"
					if numberOfTypers > 1 {
						verb = "are"
					}
					self.typingUserLabel.text = "\(names) \(verb) typing a message."
				} else {
					self.typingUserLabel.text = ""
				}
			}
		}
		
	}
	
	
	
	// Actions
	
	@IBAction func revealSendButton(_ sender: Any) {
		guard let channelId = MessageService.instance.selectedChannel?.id else { return }
		if messageTextField.text == "" {
			isTyping = false
			sendMessageButton.isHidden = true
			SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
		} else {
			if isTyping == false {
				sendMessageButton.isHidden = false
				SocketService.instance.socket.emit("startType", UserDataService.instance.name, channelId)
			}
			isTyping = true
		}
	}
	
	
	@IBAction func sendMessageButtonTapped(_ sender: UIButton) {
		if AuthService.instance.isLoggedin {
			guard let channelId = MessageService.instance.selectedChannel?.id else { return }
			guard let message = messageTextField.text else { return }
			
			SocketService.instance.sendMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
				if success {
					print("Success", "Message was \(message)", "Channel ID is  \(channelId)")
					self.messageTextField.text = ""
					self.messageTextField.resignFirstResponder()
					SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
				}
			})
		}
	}
	
	
	// Functions
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = messageTableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
			let message = MessageService.instance.messages[indexPath.row]
			cell.configureCell(message: message)
			return cell
		} else {
			return UITableViewCell()
		}
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return MessageService.instance.messages.count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	@objc func userDataDidChange(_ notif: Notification) {
		if AuthService.instance.isLoggedin {
			onLoginGetMessages()
		} else {
			channelNameLabel.text = "Please Log In"
			messageTableView.reloadData()
		}
	}
	
	@objc func channelSelected(_ notif: Notification) {
		updateWithChannel()
	}
	
	@objc func newMessage(_ notif: Notification) {
		messageTableView.reloadData()
	}
	
	
	func updateWithChannel() {
		let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
		channelNameLabel.text = "#\(channelName)"
		getMessages()
	}
	
	func onLoginGetMessages() {
		MessageService.instance.findAllChannel { (success) in
			if success {
				if MessageService.instance.channels.count > 0 {
					MessageService.instance.selectedChannel = MessageService.instance.channels[0]
					self.updateWithChannel()
				} else {
					self.channelNameLabel.text = "No channels yet!"
				}
			}
		}
	}
	
	func getMessages() {
		guard let channelId = MessageService.instance.selectedChannel?.id else { return }
		MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
			if success {
				self.messageTableView.reloadData()
			}
		}
	}
	
	func socketOnReloadData() {
		
		SocketService.instance.getMessage { (newMessage) in
			if newMessage.channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedin {
				MessageService.instance.messages.append(newMessage)
				self.messageTableView.reloadData()
				if MessageService.instance.messages.count > 0 {
					let endindex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
					self.messageTableView.scrollToRow(at: endindex, at: .bottom, animated: false)
				}
			}
		}
		
		//		SocketService.instance.getMessage { (success) in
		//			if success {
		//				self.messageTableView.reloadData()
		//				if MessageService.instance.messages.count > 0{
		//					let currentMessage = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
		//					self.messageTableView.scrollToRow(at: currentMessage, at: .bottom, animated: false)
		//				}
		//			}
		//		}
	}
	
	
	
	
	
	
	
}

//
//  SocketService.swift
//  Smack
//
//  Created by Arthur Pujols on 8/19/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import UIKit
import SocketIO
class SocketService: NSObject {
	static let instance = SocketService()
	
	override init() {
		super.init()
	}
	
	var socket : SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)
	
	func establishConnection() {
		socket.connect()
	}
	
	func closeConnection() {
		socket.disconnect()
	}
	
	
	func addChannel(channelName: String, channelDescription: String, completion:@escaping CompletionHandler) {
		
		socket.emit("newChannel", channelName, channelDescription)
		completion(true)		
	}
	
	func getChannel(completion: @escaping CompletionHandler) {
		socket.on("channelCreated") { (dataArray, ack) in
			guard let channelName = dataArray[0] as? String else { return }
			guard let channelDescription = dataArray[1] as? String else { return }
			guard let channelId = dataArray[2] as? String else { return }
			
			let newChannel = Channel(channelTitle: channelName, channelDescription: channelDescription, id: channelId)
			MessageService.instance.channels.append(newChannel)
			completion(true)
		}
	}
	
	func sendMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
		let user = UserDataService.instance
		socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
		completion(true)
	}
	
	func getMessage(completion: @escaping (_ newMessage: Message) -> Void) {
			socket.on("messageCreated") { (messageDataArray, ack) in
				guard let messageBody = messageDataArray[0] as? String else { return }
				guard let userId = messageDataArray[1] as? String else { return }
				guard let channelId = messageDataArray[2] as? String else { return }
				guard let username = messageDataArray[3] as? String else { return }
				guard let userAvatar = messageDataArray[4] as? String else { return }
				guard let userAvatarColor = messageDataArray[5] as? String else { return }
				guard let messageId = messageDataArray[6] as? String else { return }
				guard let timeStamp = messageDataArray[7] as? String else { return }
				
				let newMessage = Message(message: messageBody, username: username, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, messageId: messageId, userId: userId, timeStamp: timeStamp)
				completion(newMessage)
			}
		
	}
	
	func getTypingUsers(_ completionHandler: @escaping (_ typingUsers: [String: String]) -> Void) {
		socket.on("userTypingUpdate") { (dataArray, ack) in
			guard let typingUsers = dataArray[0] as? [String: String] else { return }
			completionHandler(typingUsers)
		}
	}
	
	
	
	
	
	
}

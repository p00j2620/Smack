//
//  MessageService.swift
//  Smack
//
//  Created by Arthur Pujols on 8/17/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class MessageService {
    
    static let instance = MessageService()
	
	var messages = [Message]()
    var channels = [Channel]()
	var unreadChannels = [String]()
	var selectedChannel : Channel?
	
    
    func findAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                if let json = JSON(data: data).array {
                    for item in json {
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                        self.channels.append(channel)
                    }
					NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
	func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler){
		Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
			if response.result.error == nil {
				guard let data = response.data else { return }
				if let json = JSON(data: data).array {
					for item in json {
						let id = item["_id"].stringValue
						let messageBody = item["messageBody"].stringValue
						let userId = item["userId"].stringValue
						let channelId = item["channelId"].stringValue
						let username = item["userName"].stringValue
						let userAvatar = item["userAvatar"].stringValue
						let userAvatarColor = item["userAvatarColor"].stringValue
						let timeStamp = item["timeStamp"].stringValue
						
						let message = Message(message: messageBody, username: username, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, messageId: id, userId: userId, timeStamp: timeStamp)
						
						self.messages.append(message)
						
					}
					completion(true)
				}
				
			} else {
				debugPrint(response.result.error as Any)
				completion(false)
			}
		}
		
		
	}
	
	func clearMessages() {
		messages.removeAll()
	}
	
	func clearChannel() {
		channels.removeAll()
	}
}



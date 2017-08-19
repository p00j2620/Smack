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
    
    var channels = [Channel]()
	
    
    func findAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
				self.channels.append(Channel(channelTitle: "First Channel", channelDescription: "This is my very first channel", id: "653545135"))
				self.channels.append(Channel(channelTitle: "Second Channel", channelDescription: "This is my second channel", id: "5wdfsdf"))
                guard let data = response.data else { return }
                if let json = JSON(data: data).array {
					
                    for item in json {
						
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                        self.channels.append(channel)
						
                    }
					print(self.channels)
                    completion(true)
                }
                
                
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
	
	func createChannelToAdd(username: String, description: String) {
		
		
		let channel = Channel(channelTitle: username, channelDescription: description, id: "")
		self.channels.append(channel)
		NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
		
	}
	
	
	
	
	
	
	
	
	
}


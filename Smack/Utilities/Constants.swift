//
//  Constants.swift
//  Smack
//
//  Created by Arthur Pujols on 8/1/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()
// URL Constants
let BASE_URL = "https://chatapideploy.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"

// Segues
let TO_LOGIN = "toLoginVCSegue"
let TO_ACCOUNT = "toAccountVCSegue"
let UNWIND_TO_CHANNELVC = "unwindToChannelVC"
let TO_AVATAR_PICKERVC = "toAvatarPickerVC"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers
let HEADER = [
	"Content-Type": "application/json; charset=utf-8"
]

// Colors
let smackPurplePlaceholder = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 0.5)

// Notification Constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")

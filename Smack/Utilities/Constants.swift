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

// Segues
let TO_LOGIN = "toLoginVCSegue"
let TO_ACCOUNT = "toAccountVCSegue"
let UNWIND_TO_CHANNELVC = "unwindToChannelVC"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"



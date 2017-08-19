//
//  AddChannelVC.swift
//  Smack
//
//  Created by Arthur Pujols on 8/18/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
	
	// Outlets
	@IBOutlet weak var usernameTextField: PlaceholderColor!
	@IBOutlet weak var bgView: UIView!
	
	@IBOutlet weak var descriptionTextField: PlaceholderColor!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
		
    }
	
	// Actions
	@IBAction func createChannelTapped(_ sender: UIButton) {
		
		let username = usernameTextField.text ?? ""
		let description = descriptionTextField.text ?? ""
		
		MessageService.instance.createChannelToAdd(username: username, description: description)
		dismiss(animated: true, completion: nil)
		
		}
	
	@IBAction func closeButtonTapped(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
	func setupView() {
		let closeOnTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeOnTap(_:)))
		bgView.addGestureRecognizer(closeOnTouch)
	}
	
	@objc func closeOnTap(_ recognizer: UITapGestureRecognizer) {
		dismiss(animated: true, completion: nil)
	}
	
}

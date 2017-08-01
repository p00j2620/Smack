//
//  ChatVC.swift
//  Smack
//
//  Created by Arthur Pujols on 8/1/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
	
	//Outlets
	@IBOutlet weak var menuBtn: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
		
		self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
		self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())

        // Do any additional setup after loading the view.
    }

}

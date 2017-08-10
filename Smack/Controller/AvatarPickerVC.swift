//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Arthur Pujols on 8/9/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
	
	// Outlets
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var segmentControl: UISegmentedControl!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.delegate = self
		collectionView.dataSource = self
		
	
	}
	// Functions
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
			return cell
		}
		return AvatarCell()
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 28
	}
	
	@IBAction func backBtnPressed(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	@IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
	}
	
}


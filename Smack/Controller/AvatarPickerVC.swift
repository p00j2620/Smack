//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Arthur Pujols on 8/9/17.
//  Copyright © 2017 Arthur Pujols. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	// Outlets
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var segmentControl: UISegmentedControl!
	
	// Variables
	var avatarType = AvatarType.dark
	
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.delegate = self
		collectionView.dataSource = self
	}
	// Functions
	
	// Creating cell prototype
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
			cell.configureCell(index: indexPath.item, type: avatarType)
			return cell
		}
		return AvatarCell()
	}
	
	// Number of collection view sections
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	// How many items to return in collection view
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 28
	}
	
	// Setting the size of reusable cell
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		var numOfColumns : CGFloat = 3
		if UIScreen.main.bounds.width > 320 {
			numOfColumns = 4
		}
		let spaceBetweenCells : CGFloat = 10
		let padding : CGFloat = 40
		let cellDimension = ((collectionView.bounds.width - padding) - (numOfColumns - 1) * spaceBetweenCells) / numOfColumns
		return CGSize(width: cellDimension, height: cellDimension)
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if avatarType == .dark {
			UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
		} else {
			UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
		}
		self.dismiss(animated: true, completion: nil)
	}
	// Dismisses Avatar Picker VC
	@IBAction func backBtnPressed(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
	// Segment control selector for light and dark avatar imgs
	@IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
		if segmentControl.selectedSegmentIndex == 0 {
			avatarType = .dark
		} else {
			avatarType = .light
		}
		collectionView.reloadData()
	}
	
	
}


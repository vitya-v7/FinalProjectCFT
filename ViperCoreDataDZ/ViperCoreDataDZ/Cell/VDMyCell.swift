//
//  VDMyCell.swift
//  VDDZCoreData
//
//  Created by Viktor Deryabin on 28.11.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit

class VDMyCell: UITableViewCell {

	@IBOutlet var firstName: UILabel?
	@IBOutlet var lastName: UILabel?
	@IBOutlet var adress: UILabel?
	static let cellIdentifier = "UserCell"
	override func awakeFromNib() {
    	super.awakeFromNib()
    	adress?.adjustsFontSizeToFitWidth = true
    	// Initialization code
	}
	
	
	func configureCell(withObject object: UserListViewModel) {
    	firstName?.text = object.firstName
    	lastName?.text = object.lastName
    	adress?.text = object.adress
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
    	super.setSelected(selected, animated: animated)
    	
    	// Configure the view for the selected state
	}

}

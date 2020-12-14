//
//  VDMyCell.swift
//  VDDZCoreData
//
//  Created by Андрей Белкин on 12.07.17.
//  Copyright © 2017 Viktor Deryabin. All rights reserved.
//

import UIKit
protocol configuringCell {
	func configureCell(withObject object: Special)
}

class VDMyCell: UITableViewCell,configuringCell {

	@IBOutlet var firstName: UILabel?
	@IBOutlet var lastName: UILabel?
	@IBOutlet var adress: UILabel?
	
	override func awakeFromNib() {
    	super.awakeFromNib()
    	adress?.adjustsFontSizeToFitWidth = true
    	// Initialization code
	}
	
	
	func configureCell(withObject object: Special) {
    	//cell.textLabel!.text = event.timestamp!.description
    	
    	let user = object as! VDUserSpecial
    	firstName?.text = user.firstName
    	lastName?.text = user.lastName
    	adress?.text = user.adress
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
    	super.setSelected(selected, animated: animated)
    	
    	// Configure the view for the selected state
	}

}

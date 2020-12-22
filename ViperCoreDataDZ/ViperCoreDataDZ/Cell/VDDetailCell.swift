//
//  VDDetailCell.swift
//  VDDZCoreData
//
//  Created by Viktor Deryabin on 20.11.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
protocol TextFieldChanged {
	func textFieldDataChanged(textField: UITextField)
}

protocol CallingPopoverByPicker {
	func callPopover(value: String)
}

class VDDetailCell: UITableViewCell,UITextFieldDelegate {
	@IBOutlet var label: UILabel?
	@IBOutlet var txtField: UITextField?
	
	var delegate1: TextFieldChanged?
	var delegate2: CallingPopoverByPicker?
	static let cellIdentifier = "DetailCell"
	static let nibName = "detailcell"

	func textFieldDidEndEditing(_ textField: UITextField) {
		//textField.resignFirstResponder()
		if textField.tag == 3 {
			delegate1?.textFieldDataChanged(textField: textField)
		}
	}

	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		if textField.tag == 4 {
			delegate1?.textFieldDataChanged(textField: textField)
			return false
		}
    	return true
	}
	
	 override func awakeFromNib() {
    	super.awakeFromNib()

    	// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
    	super.setSelected(selected, animated: animated)

    	// Configure the view for the selected state
	}

}

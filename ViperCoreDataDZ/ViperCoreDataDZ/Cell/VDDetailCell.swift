//
//  VDDetailCell.swift
//  VDDZCoreData
//
//  Created by Viktor Deryabin on 20.11.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
protocol TextFieldChanged {
	func textFieldDataChanged(tag: Int, value: String)
}

protocol CallingPopoverByPicker {
	func callPopover(cell: VDDetailCell)
}
class VDDetailCell: UITableViewCell,UITextFieldDelegate {
	@IBOutlet var label: UILabel?
	@IBOutlet var txtField: UITextField?
	
	var delegate1: TextFieldChanged?
	var delegate2: CallingPopoverByPicker?
	static let cellIdentifierForUser = "UserDetailCell"
	static let cellIdentifierForCourse = "CourseDetailCell"
	static let nibName = "detailcell"

   
	func textFieldDidEndEditing(_ textField: UITextField) {
		//textField.resignFirstResponder()
		delegate1?.textFieldDataChanged(tag: textField.tag, value: textField.text!)
	}

	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    	if delegate2 != nil  {
	    	delegate2?.callPopover(cell: self)
	    	return false
    	}
    	return true
	}
	func textFieldDidBeginEditing(_ textField: UITextField) {
    	
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

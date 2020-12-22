//
//  VDDetailCell.swift
//  VDDZCoreData
//
//  Created by Viktor Deryabin on 20.11.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
protocol TextFieldChanged {
	func textCharactersChanged(newValue: String, tag: Int)

}

class VDDetailCell: UITableViewCell,UITextFieldDelegate {
	@IBOutlet var label: UILabel?
	@IBOutlet var txtField: UITextField?
	
	var delegate1: TextFieldChanged?
	static let cellIdentifier = "DetailCell"
	static let nibName = "detailcell"


	func textField(_ textField: UITextField,
				   shouldChangeCharactersIn range: NSRange,
				   replacementString string: String) -> Bool {
		if let text = textField.text,
		   let textRange = Range(range, in: text) {
			if textField.tag != 4 {
				let updatedText = text.replacingCharacters(in: textRange, with: string)
				delegate1?.textCharactersChanged(newValue: updatedText, tag: textField.tag)
			}
		}
		return true
	}

	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		if textField.tag == 4 {
			delegate1?.textCharactersChanged(newValue: textField.text!, tag: textField.tag)
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

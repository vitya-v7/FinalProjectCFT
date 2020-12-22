//
//  PickerView.swift
//  Task5
//
//  Created by Admin on 19.09.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol PopoverOutput {
	func changeData(value: String)
}

class VDPickerController: UIViewController {

	@IBOutlet weak var picker: UIPickerView!
	@IBOutlet weak var button: UIButton!

	var options: [String]?
	var currentOption: String?
	var index: Int?
	var output: PopoverOutput?
	var initialTitle: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		options = Constants.objectOfCourse
		options?.insert("Choose object", at: 0)
		picker.delegate = self
		picker.dataSource = self
		button?.addTarget(self, action: #selector(saveData(_:)), for: .touchUpInside)

		for indx in 0 ..< Constants.objectOfCourse.count {
			if Constants.objectOfCourse[indx].capitalized == currentOption!.capitalized {
				self.index = indx
			}
		}
		picker?.selectRow((self.index ?? 0) + 1, inComponent: 0, animated: true)
		self.picker.reloadAllComponents()
	}


	@objc func saveData(_ but: UIButton) {
		let row = picker?.selectedRow(inComponent: 0)
		if let row = row, let out = output {
			out.changeData(value: options![row])
		}
		self.dismiss(animated: true, completion: nil)
	}
}

extension VDPickerController: UIPickerViewDelegate
{
	func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
		var label = view as? UILabel
		if label == nil {
			label = UILabel()
		}
		label?.text = options?[row]
		label?.adjustsFontSizeToFitWidth = true
		label?.textAlignment = .center
		guard let returnLabel = label else {
			return UILabel()
		}
		return returnLabel
	}

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		if row == 0 && component == 0 {
			pickerView.selectRow(1, inComponent: 0, animated: true)
		}
	}
}

extension VDPickerController: UIPickerViewDataSource
{
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return options?.count ?? 0
	}

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
}

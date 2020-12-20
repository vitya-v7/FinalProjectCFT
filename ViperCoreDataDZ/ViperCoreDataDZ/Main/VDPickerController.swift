//
//  VDPickerController.swift
//  VDDZCoreData
//
//  Created by Admin on 05.12.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class VDPickerController: ViewController,UIPickerViewDelegate,UIPickerViewDataSource {
	@IBOutlet var picker: UIPickerView?
	@IBOutlet var button: UIButton?
	var cellMeaning: String?
	var initialTitle: String?
	var delegate1: TextFieldChanged?
	override func viewDidLoad() {
    	super.viewDidLoad()
    	button?.addTarget(self, action: #selector(saveData(_:)), for: .touchUpInside)
    	picker?.selectRow(1, inComponent: 0, animated: true)
    	if initialTitle != nil {
	    	for i in 0 ..< VDDataManager.courseCount {
    	    	let title = VDDataManager.coursePredmet[i]
    	    	if title == initialTitle! {
	    	    	picker?.selectRow(i + 1, inComponent: 0, animated: true)
	    	    	break
    	    	}
	    	}
    	}
	}
	
	func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    	var label = view as? UILabel
    	if label == nil {
	    	label = UILabel()
    	}
    	if row == 0 {
	    	label?.font = UIFont.init(name: "Helvetica-Bold", size: 20)
	    	label?.numberOfLines = 1
	    	label?.text = String("Choose \(String(describing: cellMeaning!))")
    	}
    	else {
	    	label?.text = VDDataManager.coursePredmet[row-1]
    	}
    	label?.adjustsFontSizeToFitWidth = true
    	label?.textAlignment = .center
    	return label!
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    	if row == 0 {
	    	picker?.selectRow(row + 1, inComponent: component, animated: false)
    	}
	}
	
	@objc func saveData(_ but: UIButton) {
    	let row = picker?.selectedRow(inComponent: 0)
		
    	delegate1?.changeDictionaryData(name: cellMeaning!, value: VDDataManager.coursePredmet[row! - 1])
    	self.dismiss(animated: true, completion: nil)
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    	return VDDataManager.coursePredmet.count + 1
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
    	return 1
	}
}

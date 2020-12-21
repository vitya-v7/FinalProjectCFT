//
//  ViewControllerDetailCourse.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 17.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData


protocol TableViewReloaded: UIViewController {
	func changePredmetTextField(value: String)
}

class ViewControllerDetailCourse: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewReloaded {

	var output: PresenterDetailCourse?
	@IBOutlet var tableView: UITableView?
	override func viewDidLoad() {
    	super.viewDidLoad()
    	//course = VDCourseSpecial.getCourseByID(myIndexObject)
    	self.tableView?.delegate = self
    	self.tableView?.dataSource = self
    	self.tableView?.estimatedRowHeight = 300
    	self.tableView?.rowHeight = UITableView.automaticDimension
		var nib = UINib.init(nibName: VDDetailCell.nibName, bundle: nil)
    	self.tableView?.register(nib, forCellReuseIdentifier: VDDetailCell.cellIdentifier) // ??????
    	nib = UINib.init(nibName: VDMyCell.nibName, bundle: nil)
    	self.tableView?.register(nib, forCellReuseIdentifier: VDMyCell.cellIdentifier)
    	
    	
    	let barb = UIBarButtonItem.init(title: "Save", style: .plain, target: self, action: #selector(saveData(_:)))
    	self.navigationItem.setRightBarButtonItems([barb], animated: true)

	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    	if indexPath.section == 1 || indexPath.section == 0 && indexPath.row == output?.getTFcount() {
	    	return 90
    	}
    	return 50
	}
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    	switch section {
    	case 0:
	    	return "Course information"
    	case 1:
	    	return "Students"
    	default:
	    	NSLog("ERROR IN titleForHeaderInSection IN COURSE DETAIL VC!!!\n\n")
	    	return ""
    	}
	}
	
	func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath)
	{
    	if (indexPath.row == 0 && (indexPath.section == 1 || indexPath.section == 2)) {
	    	let cell = tableView.cellForRow(at: indexPath)
	    	cell?.backgroundColor = UIColor.red
    	}
	}
	func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
    	let cell = tableView.cellForRow(at: indexPath)
    	if (indexPath.row == 0 && (indexPath.section == 1 || indexPath.section == 2))  {
	    	cell?.backgroundColor = UIColor(red: 0.0 ,  green: 1.0 , blue: 140/255.0 , alpha: 0.2)
    	}
    	else {
	    	cell?.backgroundColor = UIColor.white
    	}
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    	if (indexPath.row == 0 && (indexPath.section == 1 || indexPath.section == 2)) {
	    	cell.backgroundColor = UIColor(red: 0.0 , green: 1.0 , blue: 140/255.0 , alpha: 0.2)
    	   
    	}
    	else {
	    	cell.backgroundColor = UIColor.white
    	}
    	 cell.selectionStyle = .none
	}

	override func didReceiveMemoryWarning() {
    	super.didReceiveMemoryWarning()
    	// Dispose of any resources that can be recreated.
	}

	// MARK: - Table view data source

	func numberOfSections(in tableView: UITableView) -> Int {
    	// #warning Incomplete implementation, return the number of sections
    	return 2
	}

	@objc func saveData(_ but: UIBarButtonItem) {
    	for i in 0..<output!.getTFcount() {
			if let cell = tableView?.cellForRow(at: IndexPath.init(row: i, section: 0)) as? VDDetailCell {
				cell.txtField!.resignFirstResponder()
			}
    	}

    	output?.updateCourse()
    	output?.dismissView()
	}
    	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    	// #warning Incomplete implementation, return the number of rows
    	switch section {
    	case 0: return output!.getTFcount() + 1
    	case 1: return output!.getStudentsCount() + 1
    	default: return 0
  
    	}
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    	if indexPath.section == 1 && indexPath.row == 0 || indexPath.section == 0 && indexPath.row == output?.getTFcount() {
	    	self.output?.callCheckViewController(myIndexPath: indexPath)
    	}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    	return (output?.getCellAtIndexPath(indexPath: indexPath))!
	}
	
	override func viewWillDisappear(_ animated: Bool) {
    	
    	if (self.isMovingFromParent){
	    	if output!.isTemporaryCourse() {
    	    	output!.daleteTemporaryCourse()
	    	}
    	}
	}
	override func viewWillAppear(_ animated: Bool) {
    	
    	output?.updateDB()
    	self.tableView?.reloadData()
	}

	func changePredmetTextField(value: String) {
		(tableView?.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! VDDetailCell).txtField!.text = value
	}
}

extension ViewControllerDetailCourse: TextFieldChanged {
	func textFieldDataChanged(tag: Int, value: String) {
		<#code#>
	}


}

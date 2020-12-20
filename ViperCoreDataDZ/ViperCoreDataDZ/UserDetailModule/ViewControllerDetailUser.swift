//
//  ViewControllerDetailUser.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 17.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData



class ViewControllerDetailUser: UIViewController, UITableViewDelegate, UITableViewDataSource
{
	
	var output: PresenterDetailUser?
	@IBOutlet var tableView: UITableView?
	override func viewDidLoad() {
		
		super.viewDidLoad()
		var nib = UINib.init(nibName: "detailcell", bundle: nil)
		self.tableView?.register(nib, forCellReuseIdentifier: "UserDetailCell")
		nib = UINib.init(nibName: "courseDescriptionCell", bundle: nil)
		self.tableView?.register(nib, forCellReuseIdentifier: "CourseCell")
		
		nib = UINib.init(nibName: "VDCourseCheckViewController", bundle: nil)
		self.tableView?.register(nib, forCellReuseIdentifier: "CoursesCheck")
		self.tableView?.delegate = self
		self.tableView?.dataSource = self
		self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Save", style: .plain, target: self, action: #selector(saveData(_:)))
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.section == 0 {
			return 50
		}
		return 90
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 0:
			return "User information"
		case 1:
			return "Courses for learning"
		case 2:
			return "Courses for teaching"
		default:
			NSLog("ERROR IN titleForHeaderInSection IN COURSE DETAIL VC!!!\n\n")
			return ""
		}
	}
	
	func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
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
		return 3
	}
	
	@objc func saveData(_ but: UIBarButtonItem) {
		for i in 0..<output!.getTFcount() {
			if let cell = tableView?.cellForRow(at: IndexPath.init(row: i, section: 0)) as? VDDetailCell {
				cell.txtField!.resignFirstResponder()
			}
		}
			output?.updateUser()
			output?.dismissView()
	}
	
	func getCoursesForTeachingCount() {
		
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		switch section {
		case 0: return output!.getTFcount()
		case 1: return output!.getCoursesCount() + 1
		case 2: return output!.getCoursesForTeachingCount() + 1
		default: return 0
			
		}
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 0 && (indexPath.section == 1 || indexPath.section == 2) {
			self.output?.callCheckViewController(myIndexPath: indexPath)
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return (output?.getCellAtIndexPath(indexPath: indexPath))!
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		
		if (self.isMovingFromParent){
			if output!.isTemporaryUser() {
				output!.daleteTemporaryUser()
			}
		}
	}
	override func viewWillAppear(_ animated: Bool) {
		
		output?.updateDB()
		self.tableView?.reloadData()
	}
}


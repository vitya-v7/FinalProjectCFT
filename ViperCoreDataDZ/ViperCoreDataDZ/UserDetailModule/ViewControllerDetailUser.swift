//
//  ViewControllerDetailUser.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 17.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData



class ViewControllerDetailUser: UIViewController
{
	var viewModelForUser = UserViewModel()
	var temporaryUserViewModel = UserViewModel()
	var viewModelsForCoursesForLearning = [CourseViewModel]()
	var viewModelsForCoursesForTeaching = [CourseViewModel]()
	
	var output: PresenterDetailUser?
	@IBOutlet var tableView: UITableView?
	override func viewDidLoad() {
		
		super.viewDidLoad()
		var nib = UINib.init(nibName: VDDetailCell.nibName, bundle: nil)
		self.tableView?.register(nib, forCellReuseIdentifier: VDDetailCell.cellIdentifier)
		nib = UINib.init(nibName: VDMyCourseCell.nibName, bundle: nil)
		self.tableView?.register(nib, forCellReuseIdentifier: VDMyCourseCell.cellIdentifier)
		nib = UINib.init(nibName: "VDCourseCheckViewController", bundle: nil)
		self.tableView?.register(nib, forCellReuseIdentifier: "CoursesCheck")
		self.tableView?.delegate = self
		self.tableView?.dataSource = self

		self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Save", style: .plain, target: self, action: #selector(saveData(_:)))
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@objc func saveData(_ but: UIBarButtonItem) {
		for i in 0..<3 {
			if let cell = tableView?.cellForRow(at: IndexPath.init(row: i, section: 0)) as? VDDetailCell {
				cell.txtField!.resignFirstResponder()
			}
		}
		viewModelForUser = temporaryUserViewModel
		output?.updateUser(viewModel: viewModelForUser)
		output?.dismissView()
	}

	override func viewWillDisappear(_ animated: Bool) {

		if (self.isMovingFromParent){
			if output!.isTemporaryUser() {
				output!.daleteTemporaryUser()
			}
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		self.viewModelForUser = output?.updateDBAndGetUserViewModel() ?? UserViewModel()
		self.tableView?.reloadData()
	}

}

extension ViewControllerDetailUser: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		switch section {
		case 0: return 3
		case 1: return viewModelsForCoursesForLearning.count + 1
		case 2: return viewModelsForCoursesForTeaching.count + 1
		default: return 0
		}
	}


	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section {
		case 0: let cell = tableView.dequeueReusableCell(withIdentifier: VDDetailCell.cellIdentifier) as! VDDetailCell

		cell.delegate1 = self
			switch indexPath.row {
			case 0:
				cell.label?.text = "firstName"
				cell.txtField?.text = viewModelForUser.firstName
				cell.txtField?.tag = 0
			case 1:
				cell.label?.text = "lastName"
				cell.txtField?.text = viewModelForUser.lastName
				cell.txtField?.tag = 1
			case 2:
				cell.label?.text = "adress"
				cell.txtField?.text = viewModelForUser.adress
				cell.txtField?.tag = 2
			default:
				fatalError("\(self.description)" + " - cellForRow Func: index out of range")
			}
		return cell
		case 1,2:
			let row = indexPath.row - 1
			var cell = VDMyCourseCell()
			let identifier = VDMyCourseCell.cellIdentifier
			cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! VDMyCourseCell
			if indexPath.row == 0 {
				cell.name?.text = " "
				cell.predmet?.text = " "
				cell.prepod?.text = "Add Course"
				return cell
			}

			if indexPath.section == 1
			{
				cell.name?.text = viewModelsForCoursesForLearning[row].name
				cell.predmet?.text = viewModelsForCoursesForLearning[row].predmet
				cell.prepod?.text = viewModelsForCoursesForLearning[row].prepod
			}
			else if indexPath.section == 2
			{
				cell.name?.text = viewModelsForCoursesForTeaching[row].name
				cell.predmet?.text = viewModelsForCoursesForTeaching[row].predmet
				cell.prepod?.text = viewModelsForCoursesForTeaching[row].prepod
			}
			return cell
		default: break
		}
		return  UITableViewCell()
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 3
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

}

extension ViewControllerDetailUser: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.section == 0 {
			return 50
		}
		return 90
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 0 && (indexPath.section == 1 || indexPath.section == 2) {
			self.output?.callCheckViewController(myIndexPath: indexPath)
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

}

extension ViewControllerDetailUser: TextFieldChanged {
	func textFieldDataChanged(tag: Int, value: String) {
		switch tag {
		case 0:
			temporaryUserViewModel.firstName = value
		case 1:
			temporaryUserViewModel.lastName = value
		case 2:
			temporaryUserViewModel.adress = value
		default:
			fatalError("\(self.description)" + " - textFieldDataChanged Func: index out of range")
		}
	}
}







//
//  ViewControllerDetailCourse.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 17.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData


class ViewControllerDetailCourse: UIViewController {
	var viewModelForCourse = CourseViewModel()
	var temporaryCourseViewModel = CourseViewModel()
	var viewModelsForStudentsForCourse = [UserViewModel]()
	var viewModelForPrepod: UserViewModel?
	var output: PresenterDetailCourse?
	var firstAppearOnScreen = true
	@IBOutlet var tableView: UITableView?
	override func viewDidLoad() {
    	super.viewDidLoad()
		temporaryCourseViewModel.name = ""
		temporaryCourseViewModel.predmet = ""
		temporaryCourseViewModel.prepod = ""

    	//course = VDCourseSpecial.getCourseByID(myIndexObject)

		var nib = UINib.init(nibName: VDDetailCell.nibName, bundle: nil)
		self.tableView?.register(nib, forCellReuseIdentifier: VDDetailCell.cellIdentifier) // ??????
		nib = UINib.init(nibName: VDMyCell.nibName, bundle: nil)
		self.tableView?.register(nib, forCellReuseIdentifier: VDMyCell.cellIdentifier)
		nib = UINib.init(nibName: "VDCourseCheckViewController", bundle: nil)
		self.tableView?.register(nib, forCellReuseIdentifier: "CoursesCheck")

		self.tableView?.delegate = self
		self.tableView?.dataSource = self
    	
    	let barb = UIBarButtonItem.init(title: "Save", style: .plain, target: self, action: #selector(saveData(_:)))
    	self.navigationItem.setRightBarButtonItems([barb], animated: true)

	}

	func setViewModelForCourse(viewModel: CourseViewModel) {
		self.viewModelForCourse = viewModel
	}

	func setTemporaryPredmetForCourse(value: String) {
		temporaryCourseViewModel.predmet = value
		//let cell = self.tableView?.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! VDDetailCell
		//cell.txtField?.text = value
		tableView?.reloadData()
	}

	override func didReceiveMemoryWarning() {
    	super.didReceiveMemoryWarning()
    	// Dispose of any resources that can be recreated.
	}

	override func viewWillDisappear(_ animated: Bool) {
    	if (self.isMovingFromParent){
	    	if output!.isTemporaryCourse() {
    	    	output!.daleteTemporaryCourse()
	    	}
    	}
	}

	override func viewWillAppear(_ animated: Bool) {
		self.viewModelForCourse = output?.updateDBAndGetCourseViewModel() ?? CourseViewModel()
		if firstAppearOnScreen == true {
			self.temporaryCourseViewModel = self.viewModelForCourse
			firstAppearOnScreen = false
		}
		self.viewModelsForStudentsForCourse = output?.getUsersForCourse() ?? [UserViewModel]()
		self.viewModelForPrepod = output?.getPrepodViewModel()
		self.tableView?.reloadData()
	}

	@objc func saveData(_ but: UIBarButtonItem) {

		for i in 0..<2{
			if let cell = tableView?.cellForRow(at: IndexPath.init(row: i, section: 0)) as? VDDetailCell {
				cell.txtField!.resignFirstResponder()
			}
		}

		viewModelForCourse.name = temporaryCourseViewModel.name
		viewModelForCourse.predmet = temporaryCourseViewModel.predmet

		output?.updateCourse(viewModel: viewModelForCourse)
		output?.dismissView()
	}

}

extension ViewControllerDetailCourse: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath)
	{
		if (indexPath.row == 0 && indexPath.section == 1 || indexPath.row == 2 && indexPath.section == 0) {
			let cell = tableView.cellForRow(at: indexPath)
			cell?.backgroundColor = UIColor.red
		}
	}

	func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath)
		if (indexPath.row == 0 && indexPath.section == 1 || indexPath.row == 2 && indexPath.section == 0)  {
			cell?.backgroundColor = UIColor(red: 0.0 ,  green: 1.0 , blue: 140/255.0 , alpha: 0.2)
		}
		else {
			cell?.backgroundColor = UIColor.white
		}
	}

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if indexPath.section == 1 && indexPath.row == 0 || indexPath.section == 0 && indexPath.row == 2 {
			cell.backgroundColor = UIColor(red: 0.0 , green: 1.0 , blue: 140/255.0 , alpha: 0.2)
		}
		else {
			cell.backgroundColor = UIColor.white
		}
		 cell.selectionStyle = .none
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 1) {
			return 50
		}
		return 90
	}
	
}


extension ViewControllerDetailCourse: UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		switch section {
		case 0: return 3
		case 1: return viewModelsForStudentsForCourse.count + 1
		default: return 0

		}
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.section == 1 && indexPath.row == 0 || indexPath.section == 0 && indexPath.row == 2 {
			var cell = self.tableView?.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! VDDetailCell
			temporaryCourseViewModel.name = cell.txtField!.text ?? ""
			cell = self.tableView?.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! VDDetailCell
			temporaryCourseViewModel.predmet = cell.txtField!.text ?? ""
			self.output?.callCheckViewController(myIndexPath: indexPath)
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		
		switch indexPath.section {
		case 0:
			if indexPath.row == 2 {
			let cell = tableView.dequeueReusableCell(withIdentifier: VDMyCell.cellIdentifier) as! VDMyCell
			if viewModelForPrepod != nil {
				cell.firstName?.text = viewModelForPrepod?.firstName ?? ""
				cell.lastName?.text = viewModelForPrepod?.lastName ?? ""
			}
			else {
				cell.firstName?.text = "There's no"
				cell.lastName?.text = " teacher"
			}
			cell.adress?.text = "Prepod"
			return cell
		}
		else {
			let cell = tableView.dequeueReusableCell(withIdentifier: VDDetailCell.cellIdentifier) as! VDDetailCell

			cell.delegate1 = self

			switch indexPath.row {
			case 0:
				cell.label?.text = "name"
				cell.txtField?.text = temporaryCourseViewModel.name
				cell.txtField?.tag = 3
			case 1:
				cell.label?.text = "predmet"
				cell.txtField?.text = temporaryCourseViewModel.predmet
				
				//cell.delegate2 = self
				cell.txtField?.tag = 4
			default:
				fatalError("\(self.description)" + " - cellForRow Func: index out of range")
			}
			return cell
		}
		case 1:
			let cell2 = tableView.dequeueReusableCell(withIdentifier: VDMyCell.cellIdentifier) as! VDMyCell
			if indexPath.row == 0 {
				cell2.firstName?.text = " "
				cell2.lastName?.text = " "
				cell2.adress?.text = "Add Student"

				return cell2
			}
			cell2.configureCell(withObject: viewModelsForStudentsForCourse[indexPath.row - 1])
			return cell2
		default: break
		}
		return cell
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
}

extension ViewControllerDetailCourse: TextFieldChanged {
	/*func textFieldDataChanged(textField: UITextField) {
	switch textField.tag {
	case 3:
	temporaryCourseViewModel.name = textField.text ?? ""
	case 4:
	output?.callPopover(value: textField.text!)
	default:
	fatalError("\(self.description)" + " - textFieldDataChanged Func: index out of range")
	}
	}*/
	func textCharactersChanged(newValue: String, tag: Int) {
		switch tag {
		case 3:
			temporaryCourseViewModel.name = newValue
		case 4:
			output?.callPopover(value: newValue)
			//temporaryCourseViewModel.predmet = newValue
		default:
			fatalError("\(self.description)" + " - textFieldDataChanged Func: index out of range")
		}
	}
}


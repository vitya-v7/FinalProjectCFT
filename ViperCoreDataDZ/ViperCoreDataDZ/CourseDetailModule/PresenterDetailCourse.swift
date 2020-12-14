//
//  PresenterDetailCourse.swift
//  ViperCoreDataDZ
//
//  Created by Андрей Белкин on 31.07.17.
//  Copyright © 2017 Viktor Deryabin. All rights reserved.
//

import UIKit
/*protocol InteractorOutput {
	func changeStudsOfCourse(checkedStudents:checkedStudents)
	func changePrepodOfCourse(checkedStudent: checkedStudent)
	func getStudentsCount() -> Int
	func getNameDataCount()
	func deleteTemporaryCourseFromDB()
	func getTemporaryCourseID()
}*/
class PresenterDetailCourse: NSObject, AssignmentProtocol, CallingPopoverByPicker {
	weak var viewController: ViewControllerDetailCourse?
	var interactor: InteractorDetailCourse?
	var wireFrame: RouterToCheckCourseController?
	let identifier2 = "CourseDetailCell"
	func changeStudsOfCourse( checkedStudents: [Bool]) {
    	interactor!.changeStudsOfCourse(checkedStudents:checkedStudents)
	}
	
	func changePrepodOfCourse(checkedStudent: NSInteger) {
    	interactor!.changePrepodOfCourse(checkedStudent: checkedStudent)
	}
	
	func getStudentsCount() -> Int {
    	return interactor!.course!.students.count
	}

	func getTFcount() -> Int {
    	return interactor!.nameData.count
	}
	
	func isTemporaryCourse() -> Bool {
    	if interactor?.temporaryCourseID != nil {
	    	return true
    	}
    	return false
	}
	
	func daleteTemporaryCourse() {
    	interactor?.deleteTemporaryCourseFromDB()
	}
	
	func callCheckViewController( myIndexPath: IndexPath?) {
    	//var vc = VDCourseDetailControllerTableViewController()
    	
    	if myIndexPath!.section == 0 && myIndexPath?.row == getTFcount() {
	    	var checkedPrepodIndex: NSInteger = -1
	    	if interactor!.course!.prepod != nil {
    	    	checkedPrepodIndex = VDUserSpecial.getUserIndexByID(id: interactor!.course!.prepod!.ID!)!
    	    	
	    	}
	    	wireFrame?.presentParticipantChecksPrepodModule(delegate: self, checked: checkedPrepodIndex, fromView: viewController!)
    	}
    	if myIndexPath!.section == 1 && myIndexPath?.row == 0 {
	    	let type:typeOfCourse = .students
	    	var boolArray = [Bool](repeating: false, count: VDUserSpecial.users.count)
	    	for obj in (interactor?.course?.students)! {
    	    	boolArray[VDUserSpecial.getUserIndexByID(id: obj.ID!)!] = true
	    	}

	    	wireFrame?.presentParticipantChecksModule(delegate: self, checked: boolArray, type: type, fromView: viewController!)
    	}
	}

	func callPopover(cell: VDDetailCell) {
		let storyboard = UIStoryboard.init(name: "Courses", bundle: nil)
		let pv = storyboard.instantiateViewController(withIdentifier: "PickerController") as! VDPickerController
		pv.cellMeaning = cell.cellMeaning
		pv.delegate1 = interactor
		if cell.txtField?.text != nil {
			pv.initialTitle = cell.txtField?.text
		}
		pv.modalPresentationStyle = UIModalPresentationStyle.popover
		pv.preferredContentSize = CGSize(width: 300, height: 300)
		pv.picker?.backgroundColor = UIColor.white
		self.viewController?.present(pv, animated: true, completion: nil)
		let popover = pv.popoverPresentationController
		popover?.permittedArrowDirections = .any
		popover?.sourceView = viewController?.view
		if let viewController = self.viewController {
			popover?.sourceRect = viewController.view.bounds
		}
	}
	
	func getCellAtIndexPath(indexPath: IndexPath) -> UITableViewCell {
    	
    	let cell = UITableViewCell()
    	let identifier: String
    	
    	switch indexPath.section {
    	case 0: if indexPath.row == 2 {
	    	var cell = VDMyCell.init()
	    	identifier = "UserCell"
	    	cell = viewController?.tableView?.dequeueReusableCell(withIdentifier: identifier) as! VDMyCell
	    	if interactor?.course?.prepod != nil {
    	    	cell.firstName?.text = interactor?.course?.prepod?.firstName
    	    	cell.lastName?.text = interactor?.course?.prepod?.lastName
	    	}
	    	else {
    	    	cell.firstName?.text = "There's no"
    	    	cell.lastName?.text = " teacher"
	    	}
	    	cell.adress?.text = "Prepod"
	    	return cell
    	}
    	else {
	    	var cell = VDDetailCell.init()
	    	identifier = "UserDetailCell"
	    	
	    	//cell.cellIndex = indexPath.row
	    	cell = viewController?.tableView?.dequeueReusableCell(withIdentifier: identifier) as! VDDetailCell
	    	cell.cellMeaning = interactor!.getNameOfTF(at: indexPath.row) 
			cell.delegate1 = interactor
	    	if indexPath.row == 0 {
				cell.label?.text = interactor!.getNameOfTF(at: indexPath.row)
				cell.txtField?.text = interactor!.getValueOfTF(at: indexPath.row)
	    	}
			else if indexPath.row == 1 {
				cell.delegate2 = self
				cell.label?.text = interactor!.getNameOfTF(at: indexPath.row)
				cell.txtField?.text = interactor!.getValueOfTF(at: indexPath.row)
			}
	    	//cell.txtField?.addTarget(self, action: #selector(textFieldPick(_:)), for: .touchDown)
	    	return cell
	    	}
    	case 1:
	    	let row = indexPath.row - 1
	    	var cell = VDMyCell()
	    	identifier = "UserCell"
	    	cell = viewController?.tableView?.dequeueReusableCell(withIdentifier: identifier) as! VDMyCell
	    	if indexPath.row == 0 {
    	    	cell.firstName?.text = " "
    	    	cell.lastName?.text = " "
    	    	cell.adress?.text = "Add Student"
    	    	
    	    	return cell
	    	}
	    	cell.configureCell(withObject:  interactor!.course!.students[row])
	    	return cell
    	default: break
    	}
    	return cell
	}
	
	func updateCourse() {
    	interactor?.updateCourseWithDictionary()
		
    	}
	func updateDB() {
    	interactor?.updateDataBase()
	}
	func dismissView() {
    	viewController?.navigationController?.popViewController(animated: true)
    	
	}
}

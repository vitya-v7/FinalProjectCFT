//
//  PresenterDetailUser.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 17.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit

class PresenterDetailUser: NSObject,AssignmentProtocol {
	weak var viewController: ViewControllerDetailUser?
	var interactor: InteractorDetailUser?
	var wireFrame: RouterToCheckController?
	let identifier2 = "UserDetailCell"

	func getCoursesCount() -> Int {
    	return interactor!.user!.courses.count
	}

	func getCoursesForTeachingCount()  -> Int {
    	return interactor!.user!.coursesForTeaching.count
	}
	func getTFcount() -> Int {
    	return interactor!.nameData.count
	}
	func isTemporaryUser() -> Bool {
    	if interactor?.temporaryUserID != nil {
	    	return true
    	}
    	return false
	}
	func daleteTemporaryUser() {
    	interactor?.deleteTemporaryUserFromDB()
	}
	func changeCoursesOfStud(checkedCourses: [Bool]) {
	   interactor!.changeCoursesOfStud(checkedCourses: checkedCourses)
	}
	func changeCoursesForTeachingOfStud(checkedCourses: [Bool]) {
	   interactor!.changeCoursesForTeachingOfStud(checkedCourses: checkedCourses)
	}

	func callCheckViewController( myIndexPath: IndexPath?) {
    	//var vc = VDUserDetailControllerTableViewController()
    	var type: typeOfCourse = .learning
    	var boolArray = [Bool](repeating: false, count: VDCourseSpecial.courses.count)
    	if myIndexPath?.row == 0 {
    	if myIndexPath!.section == 1 {
	    	for obj in (interactor?.user?.courses)! {
    	    	boolArray[VDCourseSpecial.getCourseIndexByID(id: obj.ID!)!] = true
	    	}
	    	type = .learning
    	}
    	if myIndexPath!.section == 2 {
	    	for obj in (interactor?.user?.coursesForTeaching)! {
    	    	boolArray[VDCourseSpecial.getCourseIndexByID(id: obj.ID!)!] = true
	    	}
	    	type = .teaching
    	}
    	
    	wireFrame?.presentParticipantChecksModule(delegate: self,checked: boolArray, type: type, fromView: viewController!)
    	}
	}
	func getCellAtIndexPath(indexPath: IndexPath) -> UITableViewCell {
    	switch indexPath.section {
    	case 0: let cell = viewController?.tableView?.dequeueReusableCell(withIdentifier: identifier2) as! VDDetailCell
    	cell.cellMeaning = interactor!.getNameOfTF(at: indexPath.row)
		cell.delegate1 = interactor
    	cell.label?.text = cell.cellMeaning
    	cell.txtField?.text = interactor!.getValueOfTF(at: indexPath.row) ?? ""
    	return cell
    	case 1,2:
	    	let row = indexPath.row - 1
	    	var cell = VDMyCourseCell()
	    	let identifier = "CourseCell"
	    	cell = viewController?.tableView?.dequeueReusableCell(withIdentifier: identifier) as! VDMyCourseCell
	    	if indexPath.row == 0 {
    	    	cell.name?.text = " "
    	    	cell.predmet?.text = " "
    	    	cell.prepod?.text = "Add Course"
    	    	
    	    	return cell
	    	}
	    	
	    	if indexPath.section == 1
	    	{
    	    	cell.configureCell(withObject:  interactor!.user!.courses[row])
	    	}
	    	else if indexPath.section == 2
	    	{
    	    	cell.configureCell(withObject: interactor!.user!.coursesForTeaching[row])
	    	}
	    	return cell
    	default: break
    	}
    	
    	
    	return  UITableViewCell()
	}
	
	func updateUser() {
    	
    	interactor?.updateUserWithDictionary()
    	}
	func updateDB() {
    	interactor?.updateDataBase()
	}
	func dismissView() {
    	viewController?.navigationController?.popViewController(animated: true)
    	
	}
	
	

}

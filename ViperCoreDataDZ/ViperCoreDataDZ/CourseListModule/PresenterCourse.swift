//
//  Presentercourse.swift
//  ViperCoreDataDZ
//
//  Created by Admin on 16.12.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import CoreData

class PresenterCourse: PresenterGeneralCheck {
	var temporaryCourseID: NSManagedObjectID?
	weak var viewController: ViewController?
	var wireFrame: RouterToDetailCourseController?
	var interactor: InteractorCourse?
	var interactorData = [String:[Special]]()
	var keys = [String]()
	var delegate: AssignmentProtocol?
	func updateDB() {
    	interactor?.updateDataBase()
	}
	override func updateCells() {
    	interactor?.getData(updateCell: { [weak self] (data: [String:[Special]]) -> () in
	    	self?.interactorData = data
	    	self?.keys = [String]()
	    	for key in data.keys {
    	    	self?.keys.append(key)
	    	}
	    	self?.keys.sort(by: <)
	    	var cells = [String:[configuringCell]]()
	    	for key in (self!.keys) {
    	    	for object in self!.interactorData[key]! {
	    	    	let cell = self?.viewController?.tableView?.dequeueReusableCell(withIdentifier: "CourseCell") as! configuringCell
	    	    	cell.configureCell(withObject: object)
	    	    	if cells[key] == nil {
    	    	    	cells[key] = [configuringCell]()
	    	    	}
	    	    	cells[key]!.append(cell)
    	    	}
	    	}
	    	self?.viewController?.setNewCells(cells: cells,keys: self!.keys)
    	})
	}
	
	func deleteObjectWithIndexPath(indexPath: IndexPath) {
    	
    	let id = interactorData[keys[indexPath.section]]![indexPath.row].ID
    	interactor?.deleteObjectWithIDFromDB(id: id!)
	}
	
	func callDetailViewController( myIndexPath: IndexPath?) {
    	//var vc = VDcourseDetailControllerTableViewController()
    	var course: VDCourseSpecial
    	var isTemporary = false
    	if myIndexPath == nil {
    	    	let id = interactor!.addEmptyCourse()
    	    	course = interactor!.getCourseByID(id: id)
    	    	isTemporary = true
    	}
    	else {
	    	course = interactorData[keys[myIndexPath!.section]]![myIndexPath!.row] as! VDCourseSpecial
    	}
    	wireFrame?.presentParticipantDetailsModule(course: course, isTemporary: isTemporary, fromView: viewController! as! ViewControllerCourse)
	}
	func showAll(_ but: UIBarButtonItem) {
    	VDDataManager.sharedManager.showAllObjects()
	}
	override func dismissView() {
    	viewController?.navigationController?.popViewController(animated: true)
	}
	
	
	override func changeCoursesOfStud(checkedCourses: [Bool]) {
    	delegate?.changeCoursesOfStud?(checkedCourses: checkedCourses)
    	
	}
	override func changeCoursesForTeachingOfStud(checkedCourses: [Bool]) {
    	delegate?.changeCoursesForTeachingOfStud?(checkedCourses: checkedCourses)
    	
	}
	
	
}

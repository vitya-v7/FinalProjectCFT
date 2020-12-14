//
//  PresenterUser.swift
//  ViperCoreDataDZ
//
//  Created by Андрей Белкин on 30.07.17.
//  Copyright © 2017 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData
protocol changeCoursesOfStudents {
	func changeCoursesOfStud(checkedCourses: [Bool])
	func changeCoursesForTeachingOfStud(checkedCourses: [Bool])
}

class PresenterUser: PresenterGeneralCheck {
	var temporaryUserID: NSManagedObjectID?
	weak var viewController: ViewController?
	var wireFrame: RouterToDetailController?
	var interactor: InteractorUserListProtocol?
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
	    	    	let cell = self?.viewController?.tableView?.dequeueReusableCell(withIdentifier: "UserCell") as! configuringCell
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
	
	func callDetailViewController( myIndexPath: NSIndexPath?) {
    	//var vc = VDUserDetailControllerTableViewController()
    	var user: VDUserSpecial
    	var isTemporary = false
    	if myIndexPath == nil {
    	    	let id = interactor!.addEmptyUser()
    	    	user = interactor!.getUserByID(id: id)
    	    	isTemporary = true
    	}
    	else {
	    	user = interactorData[keys[myIndexPath!.section]]![myIndexPath!.row] as! VDUserSpecial
    	}
    	wireFrame?.presentParticipantDetailsModule(user: user, isTemporary: isTemporary, fromView: viewController!)
	}
	func showAll(_ but: UIBarButtonItem) {
    	VDDataManager.sharedManager.showAllObjects()
	}
	override func dismissView() {
    	viewController?.navigationController?.popViewController(animated: true)
    	
	}
	
	override func changeStudsOfCourse(checkedStudents: [Bool]) {
    	delegate?.changeStudsOfCourse?(checkedStudents: checkedStudents)
	}
	override func changePrepodOfCourse(checkedStudent: NSInteger) {
    	delegate?.changePrepodOfCourse!(checkedStudent: checkedStudent)
	}
	
	
}

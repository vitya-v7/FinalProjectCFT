//
//  PresenterUser.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 16.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData
protocol changeCoursesOfStudents {
	func changeCoursesOfStud(checkedCourses: [Bool])
	func changeCoursesForTeachingOfStud(checkedCourses: [Bool])
}

class PresenterUser: PresenterGeneralCheck {
	var temporaryUserID: NSManagedObjectID?
	weak var viewController: ViewControllerUser?
	var wireFrame: RouterToDetailController?
	var interactor: InteractorUserListProtocol?
	var models = [VDUserSpecial]()
	var viewModels = [UserListViewModel]()
	var delegate: AssignmentProtocol?
	func updateDB() {
    	interactor?.updateDataBase()
	}
	/*override func updateCells() {
    	interactor?.getData(updateCell: { [weak self] (data: [Special]) -> () in
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
	}*/

	func getUsers() {
		interactor?.getData(getUsers: { [weak self] (data: [VDUserSpecial]) -> () in
			self?.models = data
			self?.setViewModels(users: data)
			viewController?.setViewModels(viewModels: viewModels)
		})

	}

	func setViewModels(users: [VDUserSpecial]) {
		for index in 0 ..< users.count {
			viewModels[index].firstName = users[index].firstName!
			viewModels[index].lastName = users[index].lastName!
			viewModels[index].adress = users[index].adress!
		}
	}

	func deleteObjectWithIndexPath(indexPath: IndexPath) {
		interactor?.deleteObjectFromDB(object: models[indexPath.row])
	}
	
	func callDetailViewController( myIndexPath: NSIndexPath?) {
    	var user: VDUserSpecial
    	var isTemporary = false
    	if myIndexPath == nil {
    	    	user = interactor!.addEmptyUser()
    	    	isTemporary = true
    	}
    	else {
			user = models[myIndexPath!.row]
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

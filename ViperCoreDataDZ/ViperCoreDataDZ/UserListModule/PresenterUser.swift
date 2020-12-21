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
	var viewModels = [UserViewModel]()
	var delegate: AssignmentProtocol?
	func updateDB() {
    	interactor?.updateDataBase()
	}

	func getUsers() {
		interactor?.getData(getUsers: { [weak self] (data: [VDUserSpecial]) -> () in
			self?.models = data
			self?.setViewModels(users: data)
			viewController?.setViewModels(viewModels: viewModels as! [IListViewModel])
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

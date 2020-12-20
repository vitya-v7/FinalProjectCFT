//
//  Presentercourse.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 16.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData

class PresenterCourse: PresenterGeneralCheck {
	var temporaryCourseID: NSManagedObjectID?
	weak var viewController: ViewControllerCourse?
	var wireFrame: RouterToDetailCourseController?
	var interactor: InteractorCourse?
	var models = [VDCourseSpecial]()
	var viewModels = [CourseListViewModel]()
	var delegate: AssignmentProtocol?

	func updateDB() {
		interactor?.updateDataBase()
	}
	
	/*override func updateCells() {
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
	}*/
	
	func deleteObjectWithIndexPath(indexPath: IndexPath) {
		interactor?.deleteObjectFromDB(object: models[indexPath.row])
	}

	func setViewModels(users: [VDUserSpecial]) {
		for index in 0 ..< users.count {
			viewModels[index].name = models[index].name ?? ""
			let prepodString = models[index].prepod?.firstName ?? "" + " " + models[index].prepod?.lastName ?? ""
			viewModels[index].prepod = prepodString
			viewModels[index].predmet = models[index].predmet ?? ""
		}
	}

	func getCourses() {
		interactor?.getData(getCourses: { [weak self] (data: [VDCourseSpecial]) -> () in
			self?.models = data
			self?.setViewModels(users: data)
			viewController?.setViewModels(viewModels: viewModels)
		})
	}

	func callDetailViewController(myIndexPath: IndexPath?) {
		//var vc = VDcourseDetailControllerTableViewController()
		var course: VDCourseSpecial
		var isTemporary = false
		if myIndexPath == nil {
			course = interactor!.addEmptyCourse()
			isTemporary = true
		}
		else {
			course = models[myIndexPath!.row]
		}
		wireFrame?.presentParticipantDetailsModule(course: course, isTemporary: isTemporary, fromView: viewController!)
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

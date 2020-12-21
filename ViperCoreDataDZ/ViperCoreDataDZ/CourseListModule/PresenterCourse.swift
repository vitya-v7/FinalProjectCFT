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
	var interactor: InteractorCourseListProtocol?
	var models = [VDCourseSpecial]()
	var viewModels = [CourseViewModel]()
	var delegate: AssignmentProtocol?

	func updateDB() {
		interactor?.updateDataBase()
	}
	
	
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
			self?.setViewModels(courses: data)
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

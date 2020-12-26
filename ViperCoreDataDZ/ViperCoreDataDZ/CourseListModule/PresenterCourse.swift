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
	weak var viewController: ViewController?
	var wireFrame: RouterToDetailCourseController?
	var interactor: InteractorCourseListProtocol?
	var viewModels = [CourseViewModel]()
	var delegate: AssignmentProtocol?

	func updateDB() {
		interactor?.updateDataBase()
	}
	
	
	func deleteObjectWithIndexPath(indexPath: IndexPath) {
		interactor?.deleteObjectFromDB(indexPath: indexPath)
	}

	func setViewModels(courses: [VDCourseSpecial]) {
		viewModels = [CourseViewModel]()
		for index in 0 ..< courses.count {
			let vm = CourseViewModel()
			vm.name = courses[index].name ?? ""
			var prepodString = ""
			if let prepod = courses[index].prepod {
				prepodString = (prepod.firstName ?? "") + " " + (prepod.lastName ?? "")
			}
			vm.prepod = prepodString
			vm.predmet = courses[index].predmet ?? ""
			viewModels.append(vm)
		}
	}

	func getCourses() {
		interactor?.getData(getCourses: { [weak self] (data: [VDCourseSpecial]) -> () in
			self?.setViewModels(courses: data)
			viewController?.setViewModels(viewModels: viewModels as [IListViewModel])
		})
	}

	func callDetailViewController(myIndexPath: IndexPath?) {
		var isTemporary = false
		var course: VDCourseSpecial
		if myIndexPath == nil {
			course = interactor!.addEmptyCourse()
			isTemporary = true
		}
		else {
			course = interactor!.getCourseAtIndex(indexPath: myIndexPath!)!
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

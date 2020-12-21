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

	var viewModelForUser = UserViewModel()
	var viewModelsForCoursesForLearning = [CourseViewModel]()
	var viewModelsForCoursesForTeaching = [CourseViewModel]()

	var modelForUser = VDUserSpecial()
	var modelsForCoursesForLearning = [VDCourseSpecial]()
	var modelsForCoursesForTeaching = [VDCourseSpecial]()


	/*func getUser() {
	modelForUser = interactor?.getUserModel() ?? VDUserSpecial()
	viewModelForUser = modelToViewModel(model: modelForUser)
	}*/

	/*func getTFcount() -> Int {
	return interactor!.nameData.count
	}*/

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
		interactor?.changeCoursesOfStud(checkedCourses: checkedCourses)
	}
	func changeCoursesForTeachingOfStud(checkedCourses: [Bool]) {
		interactor?.changeCoursesForTeachingOfStud(checkedCourses: checkedCourses)
	}

	func callCheckViewController( myIndexPath: IndexPath?) {
		//var vc = VDUserDetailControllerTableViewController()
		var type: typeOfCourse = .learning
		var boolArray = [Bool](repeating: false, count: VDCourseSpecial.courses.count)
		if myIndexPath?.row == 0 {
			if myIndexPath!.section == 1 {
				let courses = interactor?.getCoursesOfUserForLearning()
				if courses != nil {
					for obj in courses! {
						boolArray[VDCourseSpecial.getCourseIndexByID(id: obj.ID!)!] = true
					}
				}
				type = .learning
				wireFrame?.presentParticipantChecksModule(delegate: self, viewModels: viewModelsForCoursesForLearning, checked: boolArray, type: type, fromView: viewController!)
			}
			if myIndexPath!.section == 2 {
				let courses = interactor?.getCoursesOfUserForTeaching()
				if courses != nil {
					for obj in courses! {
						boolArray[VDCourseSpecial.getCourseIndexByID(id: obj.ID!)!] = true
					}
				}
				type = .teaching
				wireFrame?.presentParticipantChecksModule(delegate: self, viewModels: viewModelsForCoursesForTeaching, checked: boolArray, type: type, fromView: viewController!)
			}
		}
	}

	func updateUser(viewModel: UserViewModel) {
		self.viewModelForUser = viewModel
		updateModelByViewModel(model: self.modelForUser, viewModel: self.viewModelForUser)
		interactor?.updateUserWithObject(userIn: modelForUser)
	}

	func modelToViewModel(model: VDUserSpecial) -> UserViewModel {
		let userVM = UserViewModel(adress: model.adress ?? "", firstName: model.firstName ?? "", lastName: model.lastName ?? "")
		return userVM
	}

	func updateModelByViewModel(model: VDUserSpecial, viewModel: UserViewModel) {
		model.adress = viewModel.adress
		model.firstName = viewModel.firstName
		model.lastName = viewModel.lastName
	}

	func updateDBAndGetUserViewModel() -> UserViewModel {
		interactor?.updateDataBase()
		self.modelForUser = interactor?.getUserModel() ?? VDUserSpecial()
		self.viewModelForUser = modelToViewModel(model: self.modelForUser)
		return self.viewModelForUser
	}

	func dismissView() {
		viewController?.navigationController?.popViewController(animated: true)
	}
}

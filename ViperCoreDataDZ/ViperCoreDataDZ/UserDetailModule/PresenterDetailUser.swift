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

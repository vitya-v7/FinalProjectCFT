//
//  Interactorcourse.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 16.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData

protocol InteractorCourseListProtocol {
	func updateDataBase()
	func addEmptyCourse() -> VDCourseSpecial
	func deleteObjectFromDB(indexPath: IndexPath)
	func returnData() -> [VDCourseSpecial]
	func getData(getCourses:([VDCourseSpecial])->())
	func getCourseAtIndex(indexPath: IndexPath?) -> VDCourseSpecial? 
}

class InteractorCourse: NSObject, InteractorCourseListProtocol {

	func getCourseAtIndex(indexPath: IndexPath?) -> VDCourseSpecial? {
		if indexPath == nil {
			return nil
		}
		return VDCourseSpecial.courses[indexPath!.row]
	}

	func updateDataBase() {

		VDDataManager.sharedManager.updateUserBD()
		VDDataManager.sharedManager.updateCourseBD()
	}

	func returnData() -> [VDCourseSpecial] {
		var courses = VDCourseSpecial.courses
		courses.sortingBy(parameters: ["name"])
		return courses
	}
	
	func getData(getCourses:([VDCourseSpecial])->()) {
		getCourses(returnData())
	}
	
	func addEmptyCourse() -> VDCourseSpecial {

		return VDDataManager.sharedManager.addEmptyCourse()
	}
	
	func deleteObjectFromDB(indexPath: IndexPath) {
		let object = VDCourseSpecial.courses[indexPath.row]
		guard let id = object.ID else {
			return
		}
		VDDataManager.sharedManager.deleteByID(id: id)
	}
}

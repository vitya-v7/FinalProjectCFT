//
//  Interactorcourse.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 16.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData
class InteractorCourse: NSObject {
	var courses = [VDCourseSpecial]()
	func updateDataBase() {
    	
    	VDDataManager.sharedManager.updateCourseBD()
    	VDDataManager.sharedManager.updateCourseBD()
	}

	func returnData() -> [VDCourseSpecial] {
		courses = VDCourseSpecial.courses
		courses.sortingBy(parameters: ["name"])
		return courses
	}
	
	func getData(getCourses:([VDCourseSpecial])->()) {
		getCourses(returnData())
	}
	
	func addEmptyCourse() -> VDCourseSpecial {
    	
    	return VDDataManager.sharedManager.addEmptyCourse()
	}
	
	/*func getCourseByID( id: NSManagedObjectID) -> VDCourseSpecial{
    	
    	return VDCourseSpecial.courses[VDCourseSpecial.getCourseIndexByID(id: id)!]
	}*/
	
	func deleteObjectFromDB(object: VDCourseSpecial) {
		guard let id = object.ID else {
			return
		}
		VDDataManager.sharedManager.deleteByID(id: id)
	}
}

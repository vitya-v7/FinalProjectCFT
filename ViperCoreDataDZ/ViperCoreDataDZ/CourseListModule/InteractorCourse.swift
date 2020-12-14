//
//  Interactorcourse.swift
//  ViperCoreDataDZ
//
//  Created by Андрей Белкин on 30.07.17.
//  Copyright © 2017 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData
class InteractorCourse: NSObject {
	
	func updateDataBase() {
    	
    	VDDataManager.sharedManager.updateCourseBD()
    	VDDataManager.sharedManager.updateCourseBD()
	}
	
	func createDict() -> [String: [Special]]{
    	
    	return ["Courses":VDCourseSpecial.courses]
	}
	
	func getData(updateCell:(_ data:[String:[Special]])->()) {
    	
    	updateCell(createDict())
	}
	
	func addEmptyCourse() -> NSManagedObjectID {
    	
    	return VDDataManager.sharedManager.addEmptyCourse()
	}
	
	func getCourseByID( id: NSManagedObjectID) -> VDCourseSpecial{
    	
    	return VDCourseSpecial.courses[VDCourseSpecial.getCourseIndexByID(id: id)!]
	}
	
	func deleteObjectWithIDFromDB(id: NSManagedObjectID) {
    	
    	VDDataManager.sharedManager.deleteByID(id: id)
	}
	
   
	
}

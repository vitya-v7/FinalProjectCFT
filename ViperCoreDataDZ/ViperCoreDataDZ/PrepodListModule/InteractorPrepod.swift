//
//  InteractorPrepod.swift
//  ViperCoreDataDZ
//
//  Created by Андрей Белкин on 03.08.17.
//  Copyright © 2017 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData
class InteractorPrepod: NSObject, InteractorUserListProtocol{
	var nameCourse = [String]()
	func updateDataBase() {
    	VDDataManager.sharedManager.updateUserBD()
    	VDDataManager.sharedManager.updateCourseBD()
	}
	func createDict() -> [String: [Special]]{
    	
    	nameCourse = [String]()
    	var dict: [String: [VDUserSpecial]] = [:]
    	for case let course in VDCourseSpecial.courses {
	    	
	    	if let predmet = course.predmet {
    	    	if nameCourse.contains(predmet) == false {
	    	    	dict[course.predmet!] = [VDUserSpecial]()
	    	    	nameCourse.append(course.predmet!)
    	    	}
    	    	
    	    	if course.prepod != nil && ((dict[predmet]?.contains(course.prepod!)) == false) {
	    	    	dict[predmet]!.append(course.prepod!)
    	    	}
	    	}
	    	for i in dict.keys {
    	    	dict[i]?.sortingBy(parameters: ["firstName","lastName"])
	    	}
    	}
    	return dict
    	
	}

	func getData(updateCell:(_ data:[String:[Special]])->()) {
    	
    	updateCell(createDict())
	}
	func addEmptyUser() -> NSManagedObjectID {
    	
    	return VDDataManager.sharedManager.addEmptyUser()
	}
	func getUserByID( id: NSManagedObjectID) -> VDUserSpecial{
    	
    	return VDUserSpecial.users[VDUserSpecial.getUserIndexByID(id: id)!]
	}
	func deleteObjectWithIDFromDB(id: NSManagedObjectID) {
    	
    	VDDataManager.sharedManager.deleteByID(id: id)
	}
}

//
//  InteractorPrepod.swift
//  ViperCoreDataDZ
//
//  Created by Admin on 20.12.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import CoreData
class InteractorPrepod: NSObject, InteractorUserListProtocol{
	var nameCourse = [String]()
	func updateDataBase() {
    	VDDataManager.sharedManager.updateUserBD()
    	VDDataManager.sharedManager.updateCourseBD()
	}
	/*func createDict() -> [String: [Special]]{
    	
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
    	
	}*/

	func getData(getUsers:([VDUserSpecial])->()) {
		getUsers(returnData())
	}

	func addEmptyUser() -> VDUserSpecial {
    	
    	return VDDataManager.sharedManager.addEmptyUser()
	}
	func getUserByID( id: NSManagedObjectID) -> VDUserSpecial{
    	
    	return VDUserSpecial.users[VDUserSpecial.getUserIndexByID(id: id)!]
	}
	func deleteObjectFromDB(object: VDUserSpecial) {
    	
		VDDataManager.sharedManager.deleteByID(id: object.ID!)
	}

	func returnData() -> [VDUserSpecial] {
		var users = VDUserSpecial.users
		users.sortingBy(parameters: ["firstName", "lastName"])
		return users
	}

}



//
//  InteractorDetailUser.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 17.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData


class InteractorDetailUser: NSObject{

	var userID: NSManagedObjectID?
	var isTemporaryUser: Bool = false
	func deleteTemporaryUserFromDB() {
		if isTemporaryUser {
			VDDataManager.sharedManager.deleteByID(id: userID!)
		}
	}

	func getCoursesOfUserForLearning() -> [VDCourseSpecial]? {
		let ID = getCurrentUserID()
		let user = VDUserSpecial.getUserByID(id:ID)
		if let courses = user?.courses {
			return courses
		}
		return nil
	}

	func getCoursesOfUserForTeaching() -> [VDCourseSpecial]? {
		let ID = getCurrentUserID()
		let user = VDUserSpecial.getUserByID(id:ID)
		if let courses = user?.coursesForTeaching {
			return courses
		}
		return nil
	}

	func getAllCourses() -> [VDCourseSpecial]? {
		return VDCourseSpecial.courses
	}

	func getCourseIndexByID(id: NSManagedObjectID?) -> Int? {
		if let idIn = id {
			return VDCourseSpecial.getCourseIndexByID(id: idIn)
		}
		else {
			return -1
		}
	}

	func updateDataBase() {
		VDDataManager.sharedManager.updateUserBD()
		VDDataManager.sharedManager.updateCourseBD()
	}

	func updateUserWithObject(firstName: String, lastName: String, adress: String) {
		isTemporaryUser = false
		let ID = getCurrentUserID()
		let user = VDUserSpecial.getUserByID(id: ID)
		user!.firstName = firstName
		user!.lastName = lastName
		user!.adress = adress
		updateUserInDB()
	}

	func getUserModel() -> VDUserSpecial {
		let ID = getCurrentUserID()
		if let user = VDUserSpecial.getUserByID(id: ID) {
			return user
		}
		return VDUserSpecial()
	}

	func getCurrentUserID() -> NSManagedObjectID {
		var ID = NSManagedObjectID.init()
		if let tempID = userID {
			ID = tempID
		}
		return ID
	}

	func updateUserInDB() {
		var user = VDUserSpecial()
		let ID = getCurrentUserID()
		if let userIn = VDUserSpecial.getUserByID(id: ID) {
			user = userIn
		}
		VDDataManager.sharedManager.updateUser(user: user)
		VDDataManager.sharedManager.updateCourseBD()
	}

	func changeCoursesForLearningOfStud(checkedCourses: [Bool]) {
		let ID = getCurrentUserID()
		for index in 0 ..< checkedCourses.count {
			if checkedCourses[index] == false {
				VDDataManager.sharedManager.resignUserAsStudent(with: ID, fromCourseWith: VDCourseSpecial.courses[index].ID!)
			}
			else {
				VDDataManager.sharedManager.assignUserAsStudent(with: ID, onCourseWith: VDCourseSpecial.courses[index].ID!)
			}
		}

	}

	func changeCoursesForTeachingOfStud(checkedCourses: [Bool]) {
		let ID = getCurrentUserID()
		for index in 0 ..< checkedCourses.count {
			if checkedCourses[index] == false {
				VDDataManager.sharedManager.resignUserAsTeacher(with: ID, fromCourseWith: VDCourseSpecial.courses[index].ID!)
			}
			else {
				VDDataManager.sharedManager.assignUserAsTeacher(with: ID, onCourseWith: VDCourseSpecial.courses[index].ID!)
			}
		}
	}
}

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

	var temporaryUserID: NSManagedObjectID?
	var user: VDUserSpecial?

	func deleteTemporaryUserFromDB() {
		VDDataManager.sharedManager.deleteByID(id: temporaryUserID!)
	}

	func updateDataBase() {
		VDDataManager.sharedManager.updateUserBD()
		VDDataManager.sharedManager.updateCourseBD()
		updateDetailUserObjectFromDB()
	}

	func updateUserInDB() {
		VDDataManager.sharedManager.updateUser(user: user!)
		VDDataManager.sharedManager.updateCourseBD()
	}

	func getCoursesOfUserForLearning() -> [VDCourseSpecial]? {
		return user?.courses
	}

	func getCoursesOfUserForTeaching() -> [VDCourseSpecial]? {
		return user?.coursesForTeaching
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

	func updateUserWithObject(firstName: String, lastName: String, adress: String) {
		temporaryUserID = nil
		user?.firstName = firstName
		user?.lastName = lastName
		user?.adress = adress
		updateUserInDB()
	}

	func updateDetailUserObjectFromDB() {
		if user?.ID != nil {
			user = VDUserSpecial.users[VDUserSpecial.getUserIndexByID(id: user!.ID!)!]
		}
	}

	func getUserModel() -> VDUserSpecial {
		return user ?? VDUserSpecial()
	}

	func changeCoursesOfStud(checkedCourses: [Bool]) {
		for index in 0 ..< checkedCourses.count {
			if checkedCourses[index] == false {
				VDDataManager.sharedManager.resignUserAsStudent(with: user!.ID!, fromCourseWith: VDCourseSpecial.courses[index].ID!)
			}
			else {
				VDDataManager.sharedManager.assignUserAsStudent(with: user!.ID!, onCourseWith: VDCourseSpecial.courses[index].ID!)
			}
		}
	}

	func changeCoursesForTeachingOfStud(checkedCourses: [Bool]) {
		for index in 0 ..< checkedCourses.count {
			if checkedCourses[index] == false {
				VDDataManager.sharedManager.resignUserAsTeacher(with: user!.ID!, fromCourseWith: VDCourseSpecial.courses[index].ID!)
			}
			else {
				VDDataManager.sharedManager.assignUserAsTeacher(with: user!.ID!, onCourseWith: VDCourseSpecial.courses[index].ID!)
			}
		}
	}
}

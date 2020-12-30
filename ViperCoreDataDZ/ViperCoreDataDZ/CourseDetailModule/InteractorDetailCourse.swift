//
//  InteractorDetailCourse.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 17.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData
class InteractorDetailCourse: NSObject {
	
	var courseID: NSManagedObjectID?
	var isTemporaryCourse: Bool = false
	
	weak var presenter: PresenterDetailCourse?

	func updateCourseWithObject(name: String, prepod: String, predmet: String) {
		isTemporaryCourse = false
		let ID = getCurrentCourseID()
		let course = VDCourseSpecial.getCourseByID(id: ID)
		course!.name = name
		let prepodNames = prepod.components(separatedBy: " ")
		course!.prepod?.firstName = prepodNames[0]
		course!.prepod?.lastName = prepodNames[1]
		course!.predmet = predmet
		updateCourseInDB()
	}

	func getCurrentCourseID() -> NSManagedObjectID {
		var ID = NSManagedObjectID.init()
		if let tempID = courseID {
			ID = tempID
		}
		return ID
	}

	func getStudentsOfCourse() -> [VDUserSpecial]? {
		let ID = getCurrentCourseID()
		let course = VDCourseSpecial.getCourseByID(id:ID)
		if let students = course?.students {
			return students
		}
		return nil
	}

	func getAllUsers() -> [VDUserSpecial] {
		return VDUserSpecial.users
	}

	func deleteTemporaryCourseFromDB() {
		if isTemporaryCourse {
			VDDataManager.sharedManager.deleteByID(id: courseID!)
		}
	}

	func updateDataBase() {
		VDDataManager.sharedManager.updateUserBD()
		VDDataManager.sharedManager.updateCourseBD()
	}
	
	func updateCourseInDB() {
		let ID = getCurrentCourseID()
		let course = VDCourseSpecial.getCourseByID(id:ID)
		VDDataManager.sharedManager.updateCourse(course: course!)
		VDDataManager.sharedManager.updateCourseBD()
	}

	func changeStudsOfCourse( checkedStudents: [Bool]) {
		for index in 0 ..< checkedStudents.count {
			if checkedStudents[index] == false {
				VDDataManager.sharedManager.resignUserAsStudent(with: VDUserSpecial.users[index].ID!, fromCourseWith: courseID!)
			}
			else {
				VDDataManager.sharedManager.assignUserAsStudent(with: VDUserSpecial.users[index].ID!, onCourseWith: courseID!)
			}
		}
	}
	
	func getStudentIndexByID(id: NSManagedObjectID?) -> Int? {
		if let idIn = id {
			return VDUserSpecial.getUserIndexByID(id: idIn)
		}
		else {
			return -1
		}
	}

	func getPrepodOfCourse() -> VDUserSpecial? {
		let ID = getCurrentCourseID()
		let course = VDCourseSpecial.getCourseByID(id:ID)
		return course?.prepod
	}

	func getCourseModel() -> VDCourseSpecial? {
		let ID = getCurrentCourseID()
		let course = VDCourseSpecial.getCourseByID(id:ID)
		return course
	}

	func changePrepodOfCourse(checkedStudent: NSInteger) {
		var prepodTemp: VDUserSpecial?
		let ID = getCurrentCourseID()
		let course = VDCourseSpecial.getCourseByID(id:ID)
		if course?.prepod != nil {
			if checkedStudent == -1 {
				VDDataManager.sharedManager.resignUserAsTeacher(with: (course?.prepod?.ID!)!, fromCourseWith: (course?.ID)!)
			}
			else {
				let studID = VDUserSpecial.users[checkedStudent].ID
				prepodTemp = VDUserSpecial.users[checkedStudent]
				if studID != course?.prepod?.ID {
					VDDataManager.sharedManager.resignUserAsTeacher(with: (course?.prepod?.ID!)!, fromCourseWith: (course?.ID)!)
					VDDataManager.sharedManager.assignUserAsTeacher(with: studID!, onCourseWith: (course?.ID)!)
				}
			}
		}
		else {
			if checkedStudent != -1 {
				let studID = VDUserSpecial.users[checkedStudent].ID
				prepodTemp = VDUserSpecial.users[checkedStudent]
				VDDataManager.sharedManager.assignUserAsTeacher(with: studID!, onCourseWith: (course?.ID)!)
			}
		}

		if prepodTemp != nil {
			let stringWithName = (prepodTemp?.firstName ?? "") + " " + (prepodTemp?.lastName ?? "")
			presenter?.changePrepodOfCourseForUI(prepod: stringWithName)
		}
	}
}


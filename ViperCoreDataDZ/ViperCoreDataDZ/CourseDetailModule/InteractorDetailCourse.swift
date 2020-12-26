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
	
	var temporaryCourseID: NSManagedObjectID?
	weak var presenter: PresenterDetailCourse?
	var course: VDCourseSpecial?

	func updateCourseWithObject(name: String, prepod: String, predmet: String) {
		temporaryCourseID = nil
		course?.name = name
		let prepodData = prepod.components(separatedBy: " ")
		course?.prepod?.firstName = prepodData[0]
		course?.prepod?.lastName = prepodData[1]
		course?.predmet = predmet
	}

	func getStudentsOfCourse() -> [VDUserSpecial]? {
		return course?.students
	}

	func getAllUsers() -> [VDUserSpecial] {
		return VDUserSpecial.users
	}

	func deleteTemporaryCourseFromDB() {
		VDDataManager.sharedManager.deleteByID(id: temporaryCourseID!)
	}

	func updateDataBase() {
		VDDataManager.sharedManager.updateUserBD()
		VDDataManager.sharedManager.updateCourseBD()
		updateDetailCourseObject()
	}
	
	func updateCourseInDB() {
		VDDataManager.sharedManager.updateCourse(course: course!)
		VDDataManager.sharedManager.updateCourseBD()
	}

	func updateDetailCourseObject() {
		if course?.ID != nil {
			course = VDCourseSpecial.courses[VDCourseSpecial.getCourseIndexByID(id: course!.ID!)!]
		}
	}

	func changeStudsOfCourse( checkedStudents: [Bool]) {
		for index in 0 ..< checkedStudents.count {
			if checkedStudents[index] == false {
				VDDataManager.sharedManager.resignUserAsStudent(with: VDUserSpecial.users[index].ID!, fromCourseWith: (course?.ID)!)
			}
			else {
				VDDataManager.sharedManager.assignUserAsStudent(with: VDUserSpecial.users[index].ID!, onCourseWith: (course?.ID)!)

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
		return course?.prepod
	}

	func getCourseModel() -> VDCourseSpecial? {
		return course
	}

	func changePrepodOfCourse(checkedStudent: NSInteger) {
		var prepodTemp: VDUserSpecial?
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
				prepodTemp =  VDUserSpecial.users[checkedStudent]
				VDDataManager.sharedManager.assignUserAsTeacher(with: studID!, onCourseWith: (course?.ID)!)
			}
		}

		if prepodTemp != nil {
			let stringWithName = (prepodTemp?.firstName ?? "") + " " + (prepodTemp?.lastName ?? "")
			presenter?.changePrepodOfCourse(prepod: stringWithName)
		}
	}
}


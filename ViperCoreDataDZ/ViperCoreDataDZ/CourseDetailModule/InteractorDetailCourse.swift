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

	var course: VDCourseSpecial?

	func updateCourseWithObject(courseIn: VDCourseSpecial) {
		temporaryCourseID = nil
		course = courseIn
		updateCourseInDB()
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
	///////////////
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
		if course?.prepod != nil {
			if checkedStudent == -1 {
				VDDataManager.sharedManager.resignUserAsTeacher(with: (course?.prepod?.ID!)!, fromCourseWith: (course?.ID)!)
			}
			else {
				let studID = VDUserSpecial.users[checkedStudent].ID
				if studID != course?.prepod?.ID {
					VDDataManager.sharedManager.resignUserAsTeacher(with: (course?.prepod?.ID!)!, fromCourseWith: (course?.ID)!)
					VDDataManager.sharedManager.assignUserAsTeacher(with: studID!, onCourseWith: (course?.ID)!)
				}
			}
		}
		else {
			if checkedStudent != -1 {
				let studID = VDUserSpecial.users[checkedStudent].ID
				VDDataManager.sharedManager.assignUserAsTeacher(with: studID!, onCourseWith: (course?.ID)!)
			}
		}
	}
}


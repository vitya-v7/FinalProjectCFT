//
//  InteractorDetailCourse.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 17.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData
class InteractorDetailCourse: NSObject, TextFieldChanged {
	var temporaryCourseID: NSManagedObjectID?
	var delegate1: TableViewReloaded?
	var course: VDCourseSpecial? {
		didSet(courseOld) {
			for i in 0..<nameData.count {
				newData[nameData[i]] = course?[nameData[i]]
			}
		}
	}

	func deleteTemporaryCourseFromDB() {
		VDDataManager.sharedManager.deleteByID(id: temporaryCourseID!)
	}

	var nameData = ["name","predmet"]
	var newData = [String:String]()
	func getNameOfTF(at row: Int) -> String {
		return nameData[row]
	}
	func getValueOfTF(at row: Int) -> String? {
		return newData[nameData[row]]
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
	func updateCourseWithDictionary() {
		temporaryCourseID = nil
		course?.name = newData[nameData[0]]
		course?.predmet = newData[nameData[1]]
		updateCourseInDB()
	}
	func changeDictionaryData(name: String, value: String) {
		newData[name] = value
		if name == "predmet" {
			delegate1?.changePredmetTextField(value: value)
		}
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

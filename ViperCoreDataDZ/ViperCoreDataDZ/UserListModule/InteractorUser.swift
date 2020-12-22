//
//  InteractorUser.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 16.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData

protocol InteractorUserListProtocol {
	func updateDataBase()
	func addEmptyUser() -> VDUserSpecial
	func deleteObjectFromDB(object: VDUserSpecial)
	func returnData() -> [VDUserSpecial]
	func getData(getUsers:([VDUserSpecial])->())
	func getTeachersObject(object: String) -> [VDUserSpecial]
	func createDict() -> [String: [VDUserSpecial]]
}

class InteractorUser: NSObject, InteractorUserListProtocol {
	var users = [VDUserSpecial]()
	func updateDataBase() {
		VDDataManager.sharedManager.updateUserBD()
		VDDataManager.sharedManager.updateCourseBD()
	}
	func returnData() -> [VDUserSpecial]{
		users = VDUserSpecial.users
		users.sortingBy(parameters: ["firstName", "lastName"])
		return users
	}

	func getTeachersObject(object: String) -> [VDUserSpecial] {
		var teachers = [VDUserSpecial]()
		for user in users {
			for course in user.coursesForTeaching {
				if course.predmet!.capitalized == object.capitalized {
					teachers.append(user)
					break
				}
			}
		}
		return teachers
	}


	func createDict() -> [String: [VDUserSpecial]]{
		var nameCourse = [String]()
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


	func getData(getUsers:([VDUserSpecial])->()) {
		getUsers(returnData())
	}
	func addEmptyUser() -> VDUserSpecial {
		return VDDataManager.sharedManager.addEmptyUser()
	}
	
	func deleteObjectFromDB(object: VDUserSpecial) {
		guard let id = object.ID else {
			return
		}
		VDDataManager.sharedManager.deleteByID(id: id)
	}
}

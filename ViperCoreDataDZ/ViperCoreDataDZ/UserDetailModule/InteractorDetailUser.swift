//
//  InteractorDetailUser.swift
//  ViperCoreDataDZ
//
//  Created by Андрей Белкин on 31.07.17.
//  Copyright © 2017 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData
class InteractorDetailUser: NSObject, TextFieldChanged{
	var temporaryUserID: NSManagedObjectID?

	var user: VDUserSpecial? {
    	didSet(userOld) {
	    	for i in 0..<nameData.count {
    	    	newData[nameData[i]] = user?[nameData[i]]
	    	}
    	}
	}
	func deleteTemporaryUserFromDB() {
    	VDDataManager.sharedManager.deleteByID(id: temporaryUserID!)
	}
	var nameData = ["firstName","lastName","adress"]
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
    	updateDetailUserObject()
	}
	func updateUserInDB() {
    	VDDataManager.sharedManager.updateUser(user: user!)
    	VDDataManager.sharedManager.updateCourseBD()
	}
	func updateUserWithDictionary() {
    	temporaryUserID = nil
    	user?.firstName = newData[nameData[0]]
    	user?.lastName = newData[nameData[1]]
    	user?.adress = newData[nameData[2]]
    	updateUserInDB()
    	
	}
	func changeDictionaryData(name: String, value: String) {
    	newData[name] = value
	}
	func updateDetailUserObject() {
    	if user?.ID != nil {
	    	user = VDUserSpecial.users[VDUserSpecial.getUserIndexByID(id: user!.ID!)!]
    	}
	}
	///////////////
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

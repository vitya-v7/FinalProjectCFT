//
//  VDUserSpecial.swift
//  VDDZCoreData
//
//  Created by Admin on 01.12.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import CoreData
class VDUserSpecial: Special {
	var adress: String?
	var firstName: String?
	var lastName: String?
	var courses = [VDCourseSpecial]()
	var coursesForTeaching = [VDCourseSpecial]()
	
	static var users = [VDUserSpecial]()
	override subscript( string: String) -> String? {
    	switch string {
    	case "firstName":
	    	return firstName
    	case "lastName":
	    	return lastName
    	case "adress":
	    	return adress
    	default:
	    	return nil
    	}
	}
    	
	
	static func getUserIndexByID( id:NSManagedObjectID) ->  Int?{
    	
    	for i in 0 ..< VDUserSpecial.users.count {
	    	if VDUserSpecial.users[i].ID == id {
    	    	return i
	    	}
    	}
    	
    	return nil
	}
	static func deleteUserByID( id:NSManagedObjectID) ->  Bool {
    	for i in 0 ..< VDUserSpecial.users.count {
	    	if VDUserSpecial.users[i].ID == id {
    	    	VDUserSpecial.users.remove(at: i)
    	    	return true
	    	}
    	}
    	return false
	}
	func deleteCourseById(id: NSManagedObjectID) ->  Bool  {
    	for i in 0 ..< (self.courses.count) {
	    	if courses[i].ID == id {
    	    	self.courses.remove(at: i)
    	    	return true
	    	}
    	}
    	return false
	}
	
	func deleteCourseForTeachingById(id: NSManagedObjectID) ->  Bool  {
    	for i in 0 ..< (self.coursesForTeaching.count) {
	    	if coursesForTeaching[i].ID == id {
    	    	self.coursesForTeaching.remove(at: i)
    	    	return true
	    	}
    	}
    	return false
	}
	

	static func addNewObjectFromEntity( entity: VDUser) -> VDUserSpecial {
    	if getUserIndexByID(id: entity.objectID) == nil {
    	let uSpecial = VDUserSpecial()
    	uSpecial.firstName = entity.firstName
    	uSpecial.ID = entity.objectID
    	uSpecial.lastName = entity.lastName
    	uSpecial.adress = entity.adress
	    	
	    	for case let obj as VDCourse in entity.courses! {
    	    	if let usIndex = VDCourseSpecial.getCourseIndexByID(id: obj.objectID) {
    	    	//uSpecial.courses?.append(VDCourseSpecial.courses[usIndex!])
    	    	
    	    	 uSpecial.courses.insert(VDCourseSpecial.courses[usIndex], at: 0)
    	    	}
	    	}
	    	for case let obj as VDCourse in entity.coursesForTeaching! {
    	    	if let usIndex = VDCourseSpecial.getCourseIndexByID(id: obj.objectID) {
    	    	//uSpecial.coursesForTeaching?.append(VDCourseSpecial.courses[usIndex!])
    	    	uSpecial.coursesForTeaching.insert(VDCourseSpecial.courses[usIndex], at: 0)
    	    	}
	    	}
	    	uSpecial.courses.sortingBy(parameters: ["name"])
	    	uSpecial.coursesForTeaching.sortingBy(parameters: ["name"])

    	users.append(uSpecial)
		return uSpecial
    	}
		return VDUserSpecial()
	}
}

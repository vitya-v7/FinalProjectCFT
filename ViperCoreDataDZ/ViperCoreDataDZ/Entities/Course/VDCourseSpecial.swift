//
//  VDCourseSpecial.swift
//  VDDZCoreData
//
//  Created by Viktor Deryabin on 01.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData
class VDCourseSpecial: Special {
	var name: String?
	var predmet: String?
	var students = [VDUserSpecial]()
	var prepod: VDUserSpecial?
	static var courses = [VDCourseSpecial]()
	
	static func getCourseIndexByID( id:NSManagedObjectID) ->  Int? {
		
		for i in 0 ..< VDCourseSpecial.courses.count {
			if VDCourseSpecial.courses[i].ID == id {
				return i
			}
		}
		return nil
	}
	
	override subscript( string: String) -> String? {
		switch string {
		case "name":
			return name
		case "predmet":
			return predmet
		default:
			return nil
		}
	}
	
	static func deleteCourseByID( id: NSManagedObjectID) ->  Bool {
		for i in 0 ..< VDCourseSpecial.courses.count {
			if VDCourseSpecial.courses[i].ID == id {
				VDCourseSpecial.courses.remove(at: i)
				return true
			}
		}
		return false
	}
	
	func deleteStudentById(id: NSManagedObjectID) ->  Bool  {
		for i in 0 ..< self.students.count {
			if students[i].ID == id {
				self.students.remove(at: i)
				return true
			}
		}
		return false
	}
	
	
	static func addNewObjectFromEntity( entity: VDCourse) -> VDCourseSpecial {
		if getCourseIndexByID(id: entity.objectID) == nil {
			let uSpecial = VDCourseSpecial()
			
			//let sortedStudents = VDDataManager.sharedManager.getStudentsOfCourse(course: entity)
			uSpecial.name = entity.name
			uSpecial.ID = entity.objectID
			uSpecial.predmet = entity.predmet
			if entity.prepod != nil {
				if let usIndex = VDUserSpecial.getUserIndexByID(id: (entity.prepod?.objectID)!) {
					uSpecial.prepod = VDUserSpecial.users[usIndex]
				}
			}
			for case let obj as VDUser in entity.students! {
				if let usIndex = VDUserSpecial.getUserIndexByID(id: obj.objectID) {
					uSpecial.students.append(VDUserSpecial.users[usIndex])
				}
			}
			uSpecial.students.sortingBy(parameters: ["firstName","lastName"])
			
			courses.append(uSpecial)
			return uSpecial
		}
		return VDCourseSpecial()
	}
}

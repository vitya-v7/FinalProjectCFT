//
//  VDCourse+CoreDataProperties.swift
//  ViperCoreDataDZ
//
//  Created by Admin on 16.12.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import CoreData


extension VDCourse {

	@nonobjc public class func fetchRequest() -> NSFetchRequest<VDCourse> {
    	return NSFetchRequest<VDCourse>(entityName: "VDCourse")
	}

	@NSManaged public var name: String?
	@NSManaged public var predmet: String?
	@NSManaged public var prepod: VDUser?
	@NSManaged public var students: NSSet?

}

// MARK: Generated accessors for students
extension VDCourse {

	@objc(addStudentsObject:)
	@NSManaged public func addToStudents(_ value: VDUser)

	@objc(removeStudentsObject:)
	@NSManaged public func removeFromStudents(_ value: VDUser)

	@objc(addStudents:)
	@NSManaged public func addToStudents(_ values: NSSet)

	@objc(removeStudents:)
	@NSManaged public func removeFromStudents(_ values: NSSet)

}

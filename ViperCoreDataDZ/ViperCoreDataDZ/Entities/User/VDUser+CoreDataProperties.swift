//
//  VDUser+CoreDataProperties.swift
//  ViperCoreDataDZ
//
//  Created by Admin on 16.12.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import CoreData


extension VDUser {

	@nonobjc public class func fetchRequest() -> NSFetchRequest<VDUser> {
    	return NSFetchRequest<VDUser>(entityName: "VDUser")
	}

	@NSManaged public var adress: String?
	@NSManaged public var firstName: String?
	@NSManaged public var lastName: String?
	@NSManaged public var courses: NSSet?
	@NSManaged public var coursesForTeaching: NSSet?

}

// MARK: Generated accessors for courses
extension VDUser {

	@objc(addCoursesObject:)
	@NSManaged public func addToCourses(_ value: VDCourse)

	@objc(removeCoursesObject:)
	@NSManaged public func removeFromCourses(_ value: VDCourse)

	@objc(addCourses:)
	@NSManaged public func addToCourses(_ values: NSSet)

	@objc(removeCourses:)
	@NSManaged public func removeFromCourses(_ values: NSSet)

}

// MARK: Generated accessors for coursesForTeaching
extension VDUser {

	@objc(addCoursesForTeachingObject:)
	@NSManaged public func addToCoursesForTeaching(_ value: VDCourse)

	@objc(removeCoursesForTeachingObject:)
	@NSManaged public func removeFromCoursesForTeaching(_ value: VDCourse)

	@objc(addCoursesForTeaching:)
	@NSManaged public func addToCoursesForTeaching(_ values: NSSet)

	@objc(removeCoursesForTeaching:)
	@NSManaged public func removeFromCoursesForTeaching(_ values: NSSet)

}

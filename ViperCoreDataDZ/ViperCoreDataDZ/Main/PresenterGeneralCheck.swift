//
//  PresenterGeneral.swift
//  ViperCoreDataDZ
//
//  Created by Admin on 19.12.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

@objc protocol AssignmentProtocol:class{
	@objc optional func changeCoursesOfStud(checkedCourses: [Bool])
	@objc optional func changeCoursesForTeachingOfStud(checkedCourses: [Bool])
	@objc optional func changeStudsOfCourse(checkedStudents: [Bool])
	@objc optional func changePrepodOfCourse(checkedStudent: NSInteger)
}

class PresenterGeneralCheck: NSObject, AssignmentProtocol {
	func changeCoursesOfStud(checkedCourses: [Bool]) {}
	func changeCoursesForTeachingOfStud(checkedCourses: [Bool]) {}
	func changeStudsOfCourse(checkedStudents: [Bool]) {}
	func changePrepodOfCourse(checkedStudent: NSInteger) {}
	func dismissView() {}
	func updateCells() {}

}

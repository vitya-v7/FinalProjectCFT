//
//  RouterToDetailController.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 16.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData

class RouterToDetailCourseController: NSObject {
	class func setupDetailModule(course: VDCourseSpecial, isTemporary: Bool) -> UIViewController
	{
		let course = course
		let storyBoard = UIStoryboard.init(name: "Courses", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "detailCourseID") as! ViewControllerDetailCourse

		let interactor: InteractorDetailCourse = InteractorDetailCourse()
		if isTemporary {
			interactor.temporaryCourseID = course.ID
		}
		//interactor.delegate1 = vc
		interactor.course = course
		let presenter: PresenterDetailCourse = PresenterDetailCourse()
		vc.output = presenter
		presenter.viewController = vc

		presenter.interactor = interactor
		presenter.wireFrame = RouterToCheckCourseController()
		interactor.presenter = presenter
		return vc
	}
	
	func presentParticipantDetailsModule(course: VDCourseSpecial, isTemporary: Bool, fromView: ViewController) {
		let destinationVC = RouterToDetailCourseController.setupDetailModule(course: course,isTemporary:isTemporary)
		fromView.navigationController?.pushViewController(destinationVC, animated: true)
	}
}

//
//  RouterToCheckController.swift
//  ViperCoreDataDZ
//
//  Created by Андрей Белкин on 01.08.17.
//  Copyright © 2017 Viktor Deryabin. All rights reserved.
//

import UIKit

class RouterToCheckCourseController: NSObject {
	class func setupCheckModule(delegate: AssignmentProtocol, checked: [Bool], type: typeOfCourse) -> UIViewController
	{
    	let storyBoard = UIStoryboard.init(name: "MultipleCheckController", bundle: nil)
    	let vc = storyBoard.instantiateViewController(withIdentifier: "CheckController") as! ViewControllerCheck
    	let interactor: InteractorUser = InteractorUser()
    	let presenter: PresenterUser = PresenterUser()
    	vc.checked = checked
    	vc.output = presenter
    	vc.type = type
    	presenter.viewController = vc
    	presenter.delegate = delegate
    	presenter.interactor = interactor
    	return vc
	}
	
	func presentParticipantChecksModule(delegate: AssignmentProtocol, checked: [Bool], type: typeOfCourse, fromView: ViewControllerDetailCourse) {
    	
    	let destinationVC = RouterToCheckCourseController.setupCheckModule(delegate:delegate, checked:checked,type:type) as! ViewControllerCheck
    	
    	fromView.navigationController?.pushViewController(destinationVC, animated: true)
    	
	}
	
	
	
	///////////////////////////////
	
	
	class func setupCheckPrepodModule(delegate: AssignmentProtocol, checked: NSInteger) -> UIViewController
	{
    	let storyBoard = UIStoryboard.init(name: "Courses", bundle: nil)
    	let vc = storyBoard.instantiateViewController(withIdentifier: "PrepodCheck") as! ViewControllerPrepodCheck
    	let interactor: InteractorUser = InteractorUser()
    	let presenter: PresenterUser = PresenterUser()
    	vc.prepodIndex = checked
    	vc.output = presenter
    	presenter.viewController = vc
    	presenter.delegate = delegate
    	presenter.interactor = interactor
    	return vc
	}
	
	func presentParticipantChecksPrepodModule(delegate: AssignmentProtocol, checked: NSInteger, fromView: ViewControllerDetailCourse) {
    	
    	let destinationVC = RouterToCheckCourseController.setupCheckPrepodModule(delegate:delegate, checked:checked) as! ViewControllerPrepodCheck
    	
    	fromView.navigationController?.pushViewController(destinationVC, animated: true)
    	
	}
}

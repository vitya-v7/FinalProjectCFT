//
//  RouterToCheckController.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 18.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit

class RouterToCheckCourseController: NSObject {
	class func setupCheckModule(delegate: AssignmentProtocol, viewModels: [IListViewModel], checked: [Bool], type: typeOfCourse) -> ViewController
	{
    	let storyBoard = UIStoryboard.init(name: "MultipleCheckController", bundle: nil)
    	let vc = storyBoard.instantiateViewController(withIdentifier: "CheckController") as! ViewControllerCheck
    	let interactor: InteractorUser = InteractorUser()
    	let presenter: PresenterUser = PresenterUser()
    	vc.checked = checked
    	vc.output = presenter
    	vc.type = type
		vc.viewModels = viewModels
    	presenter.viewController = vc
    	presenter.delegate = delegate
    	presenter.interactor = interactor
    	return vc
	}


	func presentParticipantChecksModule(delegate: AssignmentProtocol, viewModels: [IListViewModel], checked: [Bool], type: typeOfCourse, fromView: ViewControllerDetailCourse) {
    	
		let destinationVC = RouterToCheckCourseController.setupCheckModule(delegate: delegate, viewModels: viewModels, checked: checked,type: type) as! ViewControllerCheck
    	
    	fromView.navigationController?.pushViewController(destinationVC, animated: true)
    	
	}

	///////////////////////////////
	
	
	class func setupCheckPrepodModule(delegate: AssignmentProtocol, viewModels: [IListViewModel], checked: NSInteger) -> ViewController
	{
    	let storyBoard = UIStoryboard.init(name: "Courses", bundle: nil)
    	let vc = storyBoard.instantiateViewController(withIdentifier: "PrepodCheck") as! ViewControllerPrepodCheck
    	let interactor: InteractorUser = InteractorUser()
    	let presenter: PresenterUser = PresenterUser()
    	vc.prepodIndex = checked
    	vc.output = presenter
		vc.viewModels = viewModels
    	presenter.viewController = vc
    	presenter.delegate = delegate
    	presenter.interactor = interactor
    	return vc
	}
	
	func presentParticipantChecksPrepodModule(delegate: AssignmentProtocol, viewModels: [IListViewModel], checked: NSInteger, fromView: ViewControllerDetailCourse) {
    	
    	let destinationVC = RouterToCheckCourseController.setupCheckPrepodModule(delegate:delegate, viewModels: viewModels, checked:checked) as! ViewControllerPrepodCheck
    	
    	fromView.navigationController?.pushViewController(destinationVC, animated: true)
    	
	}
}


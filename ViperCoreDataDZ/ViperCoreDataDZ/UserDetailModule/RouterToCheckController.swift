//
//  RouterToCheckController.swift
//  ViperCoreDataDZ
//
//  Created by Admin on 18.12.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class RouterToCheckController: NSObject {
	class func setupCheckModule(delegate: AssignmentProtocol, checked: [Bool], type: typeOfCourse) -> UIViewController
	{
    	let storyBoard = UIStoryboard.init(name: "MultipleCheckController", bundle: nil)
    	let vc = storyBoard.instantiateViewController(withIdentifier: "CheckController") as! ViewControllerCheck
    	let interactor: InteractorCourse = InteractorCourse()
    	let presenter: PresenterCourse = PresenterCourse()
    	vc.checked = checked
    	vc.type = type
    	presenter.viewController = vc
    	presenter.delegate = delegate
    	presenter.interactor = interactor
    	vc.output = presenter
    	
    	
    	return vc
	}
	
	func presentParticipantChecksModule(delegate: AssignmentProtocol,checked: [Bool], type: typeOfCourse, fromView: ViewControllerDetailUser) {
    	
    	let destinationVC = RouterToCheckController.setupCheckModule(delegate:delegate, checked:checked,type:type) as! ViewControllerCheck
    	
    	fromView.navigationController?.pushViewController(destinationVC, animated: true)
    	
	}
}

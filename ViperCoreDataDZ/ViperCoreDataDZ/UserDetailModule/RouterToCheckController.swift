//
//  RouterToCheckController.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 18.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit

class RouterToCheckController: NSObject {
	class func setupCheckModule(delegate: AssignmentProtocol, viewModels: [IListViewModel], checked: [Bool], type: typeOfCourse) -> UIViewController
	{
    	let storyBoard = UIStoryboard.init(name: "MultipleCheckController", bundle: nil)
    	let vc = storyBoard.instantiateViewController(withIdentifier: "CheckController") as! ViewControllerCheck
    	let interactor: InteractorUser = InteractorUser()
    	let presenter: PresenterUser = PresenterUser()
    	vc.checked = checked
    	vc.type = type
		vc.viewModels = viewModels
    	presenter.viewController = vc
    	presenter.delegate = delegate
    	presenter.interactor = interactor
    	vc.output = presenter
    	
    	return vc
	}
	
	func presentParticipantChecksModule(delegate: AssignmentProtocol, viewModels: [IListViewModel], checked: [Bool], type: typeOfCourse, fromView: ViewControllerDetailUser) {
    	
		let destinationVC = RouterToCheckController.setupCheckModule(delegate:delegate,viewModels:viewModels,checked:checked,type:type) as! ViewControllerCheck
    	
    	fromView.navigationController?.pushViewController(destinationVC, animated: true)
    	
	}
}

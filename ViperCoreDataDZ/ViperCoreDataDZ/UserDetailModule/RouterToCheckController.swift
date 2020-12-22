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

		vc.checked = checked
		vc.type = type
		vc.viewModels = viewModels
		if type == .students {
			let interactor: InteractorUser = InteractorUser()
			let presenter: PresenterUser = PresenterUser()
			presenter.viewController = vc
			presenter.delegate = delegate
			presenter.interactor = interactor
			vc.output = presenter
		}
		else {
			let interactor: InteractorCourse = InteractorCourse()
			let presenter: PresenterCourse = PresenterCourse()
			presenter.viewController = vc
			presenter.delegate = delegate
			presenter.interactor = interactor
			vc.output = presenter
		}
		return vc
	}

	func presentParticipantChecksModule(delegate: AssignmentProtocol, viewModels: [IListViewModel], checked: [Bool], type: typeOfCourse, fromView: ViewControllerDetailUser) {
		let destinationVC = RouterToCheckController.setupCheckModule(delegate:delegate,viewModels:viewModels,checked:checked,type:type) as! ViewControllerCheck
		fromView.navigationController?.pushViewController(destinationVC, animated: true)
	}
}

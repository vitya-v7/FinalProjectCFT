//
//  RouterToDetailController.swift
//  ViperCoreDataDZ
//
//  Created by Андрей Белкин on 30.07.17.
//  Copyright © 2017 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData
class RouterToDetailController: NSObject {
	class func setupDetailModule(user: VDUserSpecial, isTemporary: Bool) -> UIViewController
	{
    	let user = user
    	let storyBoard = UIStoryboard.init(name: "Users", bundle: nil)
    	let vc = storyBoard.instantiateViewController(withIdentifier: "detailUserID") as! ViewControllerDetailUser
	   
    	let interactor: InteractorDetailUser = InteractorDetailUser()
    	if isTemporary {
	    	interactor.temporaryUserID = user.ID
    	}
    	interactor.user = user
    	let presenter: PresenterDetailUser = PresenterDetailUser()
    	vc.output = presenter
    	presenter.viewController = vc
    	presenter.interactor = interactor
    	presenter.wireFrame = RouterToCheckController()
    	return vc
	}
	
	func presentParticipantDetailsModule(user: VDUserSpecial, isTemporary: Bool, fromView: ViewController) {
    	
    	let destinationVC = RouterToDetailController.setupDetailModule(user: user,isTemporary:isTemporary) as! ViewControllerDetailUser
    	
    	fromView.navigationController?.pushViewController(destinationVC, animated: true)
    	
	}
}

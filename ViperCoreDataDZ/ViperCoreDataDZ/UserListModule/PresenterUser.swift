//
//  PresenterUser.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 16.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData


class PresenterUser: PresenterGeneralCheck {
	var temporaryUserID: NSManagedObjectID?
	weak var viewController: ViewController?
	var wireFrame: RouterToDetailUserController?
	var interactor: InteractorUserListProtocol?
	var models = [VDUserSpecial]()
	var viewModels = [UserViewModel]()
	var delegate: AssignmentProtocol?
	func updateDB() {
    	interactor?.updateDataBase()
	}

	func getUsers() {
		interactor?.getData(getUsers: { [weak self] (data: [VDUserSpecial]) -> () in
			self?.models = data
			self?.setViewModels(users: data)
			viewController?.setViewModels(viewModels: viewModels as [IListViewModel])
		})
	}

	func getAllUserViewModels() -> [UserViewModel] {
		return convertModelsToViewModels(models: interactor!.returnData())
	}

	func getTeachersUsersForSpecialCourseObject(object: String) -> [UserViewModel] {
		return convertModelsToViewModels(models: interactor!.getTeachersObject(object: object))
	}


	func createDictionary()  -> [String: [UserViewModel]] {
		var dictionaryWithVM = [String: [UserViewModel]]()
		let dict = interactor!.createDict()
		for key in dict.keys {
			dictionaryWithVM[key] = [UserViewModel]()
			for item in dict[key]! {
				dictionaryWithVM[key]?.append(convertModelToViewModel(model: item))
			}
		}
		return dictionaryWithVM
	}


	func convertModelToViewModel(model: VDUserSpecial) -> UserViewModel {
		let vm = UserViewModel()
		vm.adress = model.adress ?? ""
		vm.firstName = model.firstName ?? ""
		vm.lastName = model.lastName ?? ""
		return vm
	}

	func convertModelsToViewModels(models: [VDUserSpecial]) -> [UserViewModel] {
		var viewModels = [UserViewModel]()
		for item in models {
			let vm = UserViewModel()
			vm.adress = item.adress ?? ""
			vm.firstName = item.firstName ?? ""
			vm.lastName = item.lastName ?? ""
			viewModels.append(vm)
		}
		return viewModels
	}

	func setViewModels(users: [VDUserSpecial]) {
		viewModels = [UserViewModel]()
		for index in 0 ..< users.count {
			let vm = UserViewModel()
			vm.firstName = users[index].firstName!
			vm.lastName = users[index].lastName!
			vm.adress = users[index].adress!
			viewModels.append(vm)
		}
	}

	func deleteObjectWithIndexPath(indexPath: IndexPath) {
		interactor?.deleteObjectFromDB(object: models[indexPath.row])
		models.remove(at: indexPath.row)
		viewModels.remove(at: indexPath.row)
	}

	func callDetailViewController( myIndexPath: NSIndexPath?) {
    	var user: VDUserSpecial
    	var isTemporary = false
    	if myIndexPath == nil {
    	    	user = interactor!.addEmptyUser()
    	    	isTemporary = true
    	}
    	else {
			user = models[myIndexPath!.row]
    	}
    	wireFrame?.presentParticipantDetailsModule(user: user, isTemporary: isTemporary, fromView: viewController!)
	}

	func updateModels() {
		models = interactor!.updateModels()
	}

	func showAll(_ but: UIBarButtonItem) {
    	VDDataManager.sharedManager.showAllObjects()
	}

	override func dismissView() {
    	viewController?.navigationController?.popViewController(animated: true)
    	
	}

	override func changeStudsOfCourse(checkedStudents: [Bool]) {
    	delegate?.changeStudsOfCourse?(checkedStudents: checkedStudents)
	}
	override func changePrepodOfCourse(checkedStudent: NSInteger) {
    	delegate?.changePrepodOfCourse!(checkedStudent: checkedStudent)
	}
	
	
	
}

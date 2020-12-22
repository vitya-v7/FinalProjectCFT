//
//  PresenterDetailCourse.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 17.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
protocol InteractorOutput {
	//func changeStudsOfCourse(checkedStudents:checkedStudents)
	//func changePrepodOfCourse(checkedStudent: checkedStudent)
	func getStudentsCount() -> Int
	func getNameDataCount()
	func deleteTemporaryCourseFromDB()
	func getTemporaryCourseID()
}
class PresenterDetailCourse: NSObject, AssignmentProtocol, CallingPopoverByPicker {



	weak var viewController: ViewControllerDetailCourse?
	var interactor: InteractorDetailCourse?
	var wireFrame: RouterToCheckCourseController?


	var viewModelForCourse = CourseViewModel()
	var viewModelForPrepod = UserViewModel()
	var viewModelsForStudentsForCourse = [UserViewModel]()

	var modelForCourse = VDCourseSpecial()
	var modelForPrepod = VDUserSpecial()
	var modelsForStudentsForCourse = [VDUserSpecial]()

	func changeStudsOfCourse( checkedStudents: [Bool]) {
    	interactor!.changeStudsOfCourse(checkedStudents:checkedStudents)
	}

	func updateDBAndGetCourseViewModel() -> CourseViewModel {
		interactor!.updateDataBase()
		self.modelForCourse = interactor!.getCourseModel() ?? VDCourseSpecial()
		self.viewModelForCourse = convertModelToViewModelForCourse(model: self.modelForCourse)
		return self.viewModelForCourse
	}
	
	func changePrepodOfCourse(checkedStudent: NSInteger) {
    	interactor!.changePrepodOfCourse(checkedStudent: checkedStudent)
	}


	func getStudentsCount() -> Int {
    	return interactor!.course!.students.count
	}

	func isTemporaryCourse() -> Bool {
    	if interactor!.temporaryCourseID != nil {
	    	return true
    	}
    	return false
	}
	
	func daleteTemporaryCourse() {
    	interactor!.deleteTemporaryCourseFromDB()
	}
	
	func getUsersForCourse() -> [UserViewModel] {
		modelsForStudentsForCourse = interactor!.getStudentsOfCourse() ?? [VDUserSpecial]()
		viewModelsForStudentsForCourse = convertModelsToViewModels(models: modelsForStudentsForCourse)
		return viewModelsForStudentsForCourse
	}

	func getPrepodViewModel() -> UserViewModel {
		modelForPrepod = interactor!.getPrepodOfCourse() ?? VDUserSpecial()
		viewModelForPrepod = convertModelToViewModel(model: modelForPrepod)
		return viewModelForPrepod
	}

	func updateCourse(viewModel: CourseViewModel) {
		self.viewModelForCourse = viewModel
		updateModelByViewModel(model: self.modelForCourse, viewModel: self.viewModelForCourse)
		interactor!.updateCourseWithObject(courseIn: modelForCourse)
	}

	func callCheckViewController( myIndexPath: IndexPath?) {
    	//var vc = VDCourseDetailControllerTableViewController()
    	
    	if myIndexPath!.section == 0 && myIndexPath!.row == 2 {
	    	var checkedPrepodIndex: NSInteger = -1
			if interactor!.getPrepodOfCourse() != nil {
				if let index = interactor!.getStudentIndexByID(id: interactor!.getPrepodOfCourse()!.ID) {
					checkedPrepodIndex = index
				}
	    	}
			let viewModels = convertModelsToViewModels(models:  interactor!.getAllUsers())
			wireFrame?.presentParticipantChecksPrepodModule(delegate: self, viewModels: viewModels, checked: checkedPrepodIndex, fromView: viewController!)
    	}
    	if myIndexPath!.section == 1 && myIndexPath!.row == 0 {
	    	let type:typeOfCourse = .students

			var boolArray = [Bool](repeating: false, count: interactor!.getAllUsers().count )
			if let students = interactor!.getStudentsOfCourse() {
				for obj in students {
					boolArray[VDUserSpecial.getUserIndexByID(id: obj.ID!)!] = true
				}
			}
			let viewModels = convertModelsToViewModels(models:  interactor!.getAllUsers())
			wireFrame?.presentParticipantChecksModule(delegate: self, viewModels: viewModels,checked: boolArray, type: type, fromView: viewController!)
    	}
	}

	func callPopover(cell: VDDetailCell) {
		let storyboard = UIStoryboard.init(name: "Courses", bundle: nil)
		let pv = storyboard.instantiateViewController(withIdentifier: "PickerController") as! VDPickerController
		pv.cellMeaning = "predmet" 
		//pv.delegate1 = interactor
		if cell.txtField?.text != nil {
			pv.initialTitle = cell.txtField?.text
		}
		pv.modalPresentationStyle = UIModalPresentationStyle.popover
		pv.preferredContentSize = CGSize(width: 300, height: 300)
		pv.picker?.backgroundColor = UIColor.white
		self.viewController?.present(pv, animated: true, completion: nil)
		let popover = pv.popoverPresentationController
		popover?.permittedArrowDirections = .any
		popover?.sourceView = viewController?.view
		if let viewController = self.viewController {
			popover?.sourceRect = viewController.view.bounds
		}
	}


	func updateModelByViewModel(model: VDCourseSpecial, viewModel: CourseViewModel) {
		model.name = viewModel.name
		model.predmet = viewModel.predmet
		let fullNameArr = viewModel.prepod.components(separatedBy: " ")
		model.prepod?.firstName = fullNameArr[0]
		model.prepod?.lastName = fullNameArr[1]
	}

	func convertModelToViewModelForCourse(model: VDCourseSpecial) -> CourseViewModel {
		let vm = CourseViewModel()
		vm.name = model.name ?? ""
		vm.predmet = model.predmet ?? ""
		vm.prepod = (model.prepod?.firstName ?? "") + " " + (model.prepod?.lastName ?? "")
		return vm
	}


	func convertModelToViewModel(model: VDUserSpecial) -> UserViewModel {
		let vm = UserViewModel()
		vm.firstName = model.firstName ?? ""
		vm.lastName = model.lastName ?? ""
		vm.adress = model.adress ?? ""
		return vm
	}

	func convertModelsToViewModels(models: [VDUserSpecial]) -> [UserViewModel] {
		var viewModels = [UserViewModel]()
		for item in models {
			let vm = convertModelToViewModel(model: item)
			viewModels.append(vm)
		}
		return viewModels
	}


	func updateDB() {
    	interactor!.updateDataBase()
	}
	func dismissView() {
    	viewController?.navigationController?.popViewController(animated: true)
    	
	}
}


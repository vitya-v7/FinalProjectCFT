//
//  ViewController.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 16.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit

class ViewControllerCourse: ViewController {
	
	var output: PresenterCourse?
	var viewModels = [CourseListViewModel]()

	override func viewDidLoad() {
    	super.viewDidLoad()
    	self.identifier = "CourseCell"
    	
    	output = PresenterCourse()
    	output?.viewController = self
    	output?.wireFrame = RouterToDetailCourseController()
    	//dataSource.setCellType(cellIdentifier: "UserCell")
    	let interactor: InteractorCourse = InteractorCourse()
    	output?.updateCells()
    	output?.interactor = interactor
    	//VDDataManager.sharedManager.updatecourseBD()
    	//VDDataManager.sharedManager.updateCourseBD()
    	    	let but = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(myEditing(but:)))
    	
    	
    	self.navigationItem.leftBarButtonItem = but
    	let but1 = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
    	//let but2 = UIBarButtonItem.init(title: "Show DB", style: .plain, target: self, action: #selector(showAll(_:)))
    	self.navigationItem.setRightBarButtonItems([but1], animated: true)
    	// Do any additional setup after loading the view, typically from a nib.
	}
	
	
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    	
    	if editingStyle == .delete {
	    	output?.deleteObjectWithIndexPath(indexPath: indexPath)
	    	tableView.beginUpdates()
	    	tableView.deleteRows(at: [indexPath], with: .fade)
	    	tableView.endUpdates()
    	}
    	
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    	output?.callDetailViewController(myIndexPath: indexPath)
    	self.tableView?.reloadData()
	}
	@objc func insertNewObject(_ sender: Any) {
    	output?.callDetailViewController(myIndexPath: nil)
	}
	
	func setViewModels(viewModels: [CourseListViewModel]) {
		self.viewModels = viewModels
	}

	func updateViewModels() {
		output?.getCourses()
	}

	override func viewWillAppear(_ animated: Bool) {
    	output?.updateDB()
    	output?.updateCells()
    	tableView?.reloadData()
	}
	
	
	override func didReceiveMemoryWarning() {
    	super.didReceiveMemoryWarning()
    	// Dispose of any resources that can be recreated.
	}


}


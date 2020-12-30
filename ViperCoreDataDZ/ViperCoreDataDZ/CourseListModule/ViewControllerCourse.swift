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
	var viewModels = [CourseViewModel]()

	override func viewDidLoad() {
		super.viewDidLoad()
		let nib = UINib.init(nibName: VDMyCourseCell.nibName, bundle: nil)
		self.tableView?.register(nib, forCellReuseIdentifier: VDMyCourseCell.cellIdentifier)
		let but1 = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(myEditing(_:)))
		self.navigationItem.leftBarButtonItem = but1
		output = PresenterCourse()
		output?.viewController = self
		output?.wireFrame = RouterToDetailCourseController()
		let interactor: InteractorCourse = InteractorCourse()
		output?.interactor = interactor
		tableView?.delegate = self
		tableView?.dataSource = self
		self.title = "Courses"
		let but2 = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
		self.navigationItem.setRightBarButtonItems([but2], animated: true)
	}
	
	@objc func myEditing( _: UIBarButtonItem) {
		if (self.tableView?.isEditing == false) {
			self.tableView?.isEditing = true
		}
		else {
			self.tableView?.isEditing = false
		}
	}

	@objc func insertNewObject(_ sender: Any) {
		output?.callDetailViewController(myIndexPath: nil)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		output?.updateDB()
		updateViewModels()
	}

	override func awakeFromNib() {
		super.awakeFromNib()
	}

	override func setViewModels(viewModels: [IListViewModel]) {
		self.viewModels = viewModels as! [CourseViewModel]
	}

	func updateViewModels() {
		output?.getCourses()
		tableView?.reloadData()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension ViewControllerCourse: UITableViewDelegate {
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

		if editingStyle == .delete {
			viewModels.remove(at: indexPath.row)
			output?.deleteObjectWithIndexPath(indexPath: indexPath)
			tableView.beginUpdates()
			tableView.deleteRows(at: [indexPath], with: .fade)
			tableView.endUpdates()
			tableView.reloadData()
		}
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		output?.callDetailViewController(myIndexPath: indexPath)
		self.tableView?.reloadData()
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
	{
		return 90
	}
}

extension ViewControllerCourse: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModels.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: VDMyCourseCell.cellIdentifier, for: indexPath) as? VDMyCourseCell

		guard let cellIn = cell else { return UITableViewCell() }
		cellIn.configureCell(withObject: viewModels[indexPath.row])
		return cellIn
	}
}

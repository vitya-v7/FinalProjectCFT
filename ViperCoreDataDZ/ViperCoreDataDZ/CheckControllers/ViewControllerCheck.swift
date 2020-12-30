//
//  ViewControllerCheck.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 18.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit


enum typeOfCourse {
	case learning
	case teaching
	case students
}

class ViewControllerCheck: ViewController {
	var viewModels: [IListViewModel]?
	var output: PresenterGeneralCheck?
	var checked : [Bool]?
	var type: typeOfCourse = .learning
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView?.delegate = self
		tableView?.dataSource = self
		var nib = UINib.init(nibName: VDMyCourseCell.nibName, bundle: nil)
		tableView?.register(nib, forCellReuseIdentifier: VDMyCourseCell.cellIdentifier)
		nib = UINib.init(nibName: VDMyCell.nibName, bundle: nil)
		tableView?.register(nib, forCellReuseIdentifier: VDMyCell.cellIdentifier)
		self.navigationItem.rightBarButtonItems = []
		self.navigationItem.leftBarButtonItems = []
		let but = UIBarButtonItem.init(title: NSLocalizedString("Save", comment: "") , style: .plain, target: self, action: #selector(saveChoice(_:)))
		self.navigationItem.setRightBarButton(but, animated: true)		
	}
	
	@objc func saveChoice(_ but: UIBarButtonItem) {
		
		switch type {
		case .learning:
			output?.changeCoursesForLearningOfStud(checkedCourses: checked!)
			break
		case .teaching:
			output?.changeCoursesForTeachingOfStud(checkedCourses: checked!)
			break
		case .students:
			output?.changeStudsOfCourse(checkedStudents: checked!)
			break
		}
		output?.dismissView()
		
	}
	
	override func didReceiveMemoryWarning() {
		
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension ViewControllerCheck: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
	{
		return 90
	}
	
	func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath)
	{
		let cell = tableView.cellForRow(at: indexPath)
		cell?.backgroundColor = UIColor.white
	}
	
	func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath)
	{
		let cell = tableView.cellForRow(at: indexPath)
		cell?.backgroundColor = UIColor.white
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let cell = tableView.cellForRow(at: indexPath)
		cell?.selectionStyle = .none
		if cell?.accessoryType == .checkmark {
			
			checked?[indexPath.row] = false
			cell?.accessoryType = .none
		}
		else {
			
			checked?[indexPath.row] = true
			cell?.accessoryType = .checkmark
		}
	}
}

extension ViewControllerCheck: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let count = viewModels?.count {
			return count
		}
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if type == .learning || type == .teaching {
			let cell = tableView.dequeueReusableCell(withIdentifier: VDMyCourseCell.cellIdentifier, for: indexPath) as? VDMyCourseCell
			if checked![indexPath.row] == true {
				cell?.accessoryType = .checkmark
			}
			if checked![indexPath.row] == false {
				cell?.accessoryType = .none
			}
			guard let cellIn = cell, let vModels = viewModels else { return UITableViewCell() }
			cellIn.configureCell(withObject: vModels[indexPath.row] as! CourseViewModel)
			return cellIn
		}
		if type == .students {
			let cell = tableView.dequeueReusableCell(withIdentifier: VDMyCell.cellIdentifier, for: indexPath) as? VDMyCell
			if checked![indexPath.row] == true {
				cell?.accessoryType = .checkmark
			}
			if checked![indexPath.row] == false {
				cell?.accessoryType = .none
			}
			guard let cellIn = cell, let vModels = viewModels else { return UITableViewCell() }
			cellIn.configureCell(withObject: vModels[indexPath.row] as! UserViewModel)
			return cellIn
		}
		return UITableViewCell()
	}
}

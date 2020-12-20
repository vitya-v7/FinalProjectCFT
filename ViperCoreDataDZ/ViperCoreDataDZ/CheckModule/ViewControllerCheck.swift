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
	var output: PresenterGeneralCheck?
	var checked : [Bool]?
	var type: typeOfCourse = .learning
	
	override func viewDidLoad() {
    	super.viewDidLoad()
    	self.navigationItem.rightBarButtonItems = []
    	self.navigationItem.leftBarButtonItems = []
    	let but = UIBarButtonItem.init(title: NSLocalizedString("Save", comment: "") , style: .plain, target: self, action: #selector(saveChoice(_:)))
    	self.navigationItem.setRightBarButton(but, animated: true)

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
   
	override func setNewCells(cells:[String:[configuringCell]], keys: [String]) {
    	
    	dataSource.setDataDictionary(data: cells, keys: keys)
	}
	
	override func viewWillLayoutSubviews() {
    	
    	super.viewWillLayoutSubviews()
    	
    	for index in 0 ..< checked!.count {
	    	if checked?[index] == true {
    	    	let cell = tableView?.cellForRow(at: IndexPath.init(row: index, section: 0))
    	    	cell?.accessoryType = .checkmark
	    	}
    	}
	}
	@objc func saveChoice(_ but: UIBarButtonItem) {
    	
    	switch type {
    	case .learning:
	    	output?.changeCoursesOfStud(checkedCourses: checked!)
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
	override func viewWillAppear(_ animated: Bool) {
    	
    	output?.updateCells()
    	tableView?.reloadData()
	}


	/*
	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    	// Get the new view controller using segue.destinationViewController.
    	// Pass the selected object to the new view controller.
	}
	*/

}

//
//  ViewControllerPrepodCheck.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 20.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
protocol changePrepodOfCourse {
	
	func changePrepodOfCourse(checkedStudent: Int?)
}
class ViewControllerPrepodCheck: ViewController {
   
	var output: PresenterGeneralCheck?
    	var prepodIndex: NSInteger = -1
    	override func viewDidLoad() {
	    	super.viewDidLoad()
	    	
	    	self.navigationItem.rightBarButtonItems = []
	    	self.navigationItem.leftBarButtonItems = []
	    	let but = UIBarButtonItem.init(title: "Save", style: .plain, target: self, action: #selector(saveChoice(_:)))
	    	self.navigationItem.setRightBarButton(but, animated: true)
	    	// Do any additional setup after loading the view.
    	}
    	@objc func saveChoice(_ but: UIBarButtonItem) {
	    	
	    	output!.changePrepodOfCourse(checkedStudent: prepodIndex)
	    	output?.dismissView()
    	}
    	override func viewWillLayoutSubviews() {
	    	if prepodIndex != -1 {
    	    	let cell = tableView?.cellForRow(at: IndexPath.init(row: prepodIndex, section: 0))
    	    	cell?.accessoryType = .checkmark
	    	}
    	}
    	override func didReceiveMemoryWarning() {
	    	super.didReceiveMemoryWarning()
	    	// Dispose of any resources that can be recreated.
    	}
	
	
	override func viewWillAppear(_ animated: Bool) {
    	
    	output?.updateCells()
    	tableView?.reloadData()
	}
    	
    	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	    	let cell = tableView.cellForRow(at: indexPath)
	    	cell?.selectionStyle = .none
	    	if cell?.accessoryType == .checkmark {
    	    	prepodIndex = -1
    	    	cell?.accessoryType = .none
	    	}
	    	else {
    	    	if prepodIndex != -1 {
	    	    	let cell2 = tableView.cellForRow(at: IndexPath.init(row: prepodIndex, section: 0))
	    	    	cell2?.accessoryType = .none
    	    	}
    	    	prepodIndex = indexPath.row
    	    	cell?.accessoryType = .checkmark
	    	}
	    	
    	}
    	
}



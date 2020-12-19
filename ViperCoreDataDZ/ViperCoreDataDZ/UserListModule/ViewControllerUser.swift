//
//  ViewController.swift
//  ViperCoreDataDZ
//
//  Created by Admin on 16.12.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewControllerUser: ViewController {
	
	var output: PresenterUser?
	
	override func viewDidLoad() {
    	super.viewDidLoad()
    	self.identifier = "UserCell"
    	output = PresenterUser()
    	output?.viewController = self
    	output?.wireFrame = RouterToDetailController()
    	//dataSource.setCellType(cellIdentifier: "UserCell")
    	let interactor: InteractorUser = InteractorUser()
    	output?.interactor = interactor
    	output?.updateCells()
    	
    	//VDDataManager.sharedManager.updateUserBD()
    	//VDDataManager.sharedManager.updateCourseBD()
    	    	let but = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(myEditing(but:)))
    	
    	
    	self.navigationItem.leftBarButtonItem = but
    	let but1 = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
    	//let but2 = UIBarButtonItem.init(title: "Show DB", style: .plain, target: self, action: #selector(showAll(_:)))
    	self.navigationItem.setRightBarButtonItems([but1], animated: true)
    	// Do any additional setup after loading the view, typically from a nib.
	}
	
	
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    	output?.callDetailViewController(myIndexPath: indexPath as NSIndexPath)
    	self.tableView?.reloadData()
	}
	@objc func insertNewObject(_ sender: Any) {
    	
    	output?.callDetailViewController(myIndexPath: nil)
	}
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    	if editingStyle == .delete {
	    	output?.deleteObjectWithIndexPath(indexPath: indexPath)
	    	tableView.beginUpdates()
	    	tableView.deleteRows(at: [indexPath], with: .fade)
	    	tableView.endUpdates()
    	}
    	
	}
	override func setNewCells(cells:[String:[configuringCell]], keys: [String]) {
    	dataSource.setDataDictionary(data: cells, keys: keys)
	}
	override func viewWillAppear(_ animated: Bool) {
    	
    	/*VDDataManager.sharedManager.updateUserBD()
    	VDDataManager.sharedManager.updateCourseBD()
    	dataSource.setDataDictionary(data: output?.createDict())*/
    	output?.updateDB()
    	output?.updateCells()
    	tableView?.reloadData()
	}
	
	
	override func didReceiveMemoryWarning() {
    	super.didReceiveMemoryWarning()
    	// Dispose of any resources that can be recreated.
	}


}


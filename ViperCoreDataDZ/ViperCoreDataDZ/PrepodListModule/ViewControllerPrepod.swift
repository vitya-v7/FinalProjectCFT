//
//  ViewControllerPrepod.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 20.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit

class ViewControllerPrepod: ViewController {

	var output: PresenterUser?
	
	override func viewDidLoad() {
    	super.viewDidLoad()
    	output = PresenterUser()
    	output?.viewController = self
    	output?.wireFrame = RouterToDetailController()
    	let interactor: InteractorPrepod = InteractorPrepod()
    	output?.interactor = interactor
    	output!.updateCells()
	}
	

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    	output?.callDetailViewController(myIndexPath: indexPath as NSIndexPath)
    	self.tableView?.reloadData()
	}
	
	
	override func setNewCells(cells:[String:[configuringCell]], keys: [String]) {
    	dataSource.setDataDictionary(data: cells, keys: keys)
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

//
//  ViewControllerUser.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 16.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//
import Foundation
import UIKit

class ViewControllerUser: UIViewController {
	
	var output: PresenterUser?
	var viewModels = [UserListViewModel]()
	@IBOutlet var tableView: UITableView?


	override func viewDidLoad() {
    	super.viewDidLoad()
		let nib = UINib.init(nibName: "userDescriptionCell", bundle: nil)
		self.tableView?.register(nib, forCellReuseIdentifier: VDMyCell.cellIdentifier)

		let but1 = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(myEditing(_:)))

		self.navigationItem.leftBarButtonItem = but1
    	output = PresenterUser()
    	output?.viewController = self
    	output?.wireFrame = RouterToDetailController()
    	//dataSource.setCellType(cellIdentifier: "UserCell")
    	let interactor: InteractorUser = InteractorUser()
    	output?.interactor = interactor
		tableView?.delegate = self
		tableView?.dataSource = self
    	//VDDataManager.sharedManager.updateUserBD()
    	//VDDataManager.sharedManager.updateCourseBD()

    	let but2 = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
    	self.navigationItem.setRightBarButtonItems([but2], animated: true)
    	// Do any additional setup after loading the view, typically from a nib.
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

extension ViewControllerUser: IListViewController {
	func setViewModels(viewModels: [IListViewModel]) {
		self.viewModels = viewModels as! [UserListViewModel]
	}

	func updateViewModels() {
		output?.getUsers()
	}
}

extension ViewControllerUser: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		output?.callDetailViewController(myIndexPath: indexPath as NSIndexPath)
		self.tableView?.reloadData()
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			output?.deleteObjectWithIndexPath(indexPath: indexPath)
			tableView.beginUpdates()
			tableView.deleteRows(at: [indexPath], with: .fade)
			tableView.endUpdates()
		}
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
	{
		return 90
	}

}

extension ViewControllerUser: UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModels.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: VDMyCell.cellIdentifier, for: indexPath) as? VDMyCell

		guard let cellIn = cell else { return UITableViewCell() }
		cellIn.configureCell(withObject: viewModels[indexPath.row])
		return cellIn
	}
}

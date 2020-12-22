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
	var viewModel: [String : [UserViewModel]]?
	var allViewModel = [UserViewModel]()
	var keys: [String]?

	override func viewDidLoad() {
		super.viewDidLoad()
		let nib = UINib.init(nibName: VDMyCell.nibName, bundle: nil)
		self.tableView?.register(nib, forCellReuseIdentifier: VDMyCell.cellIdentifier)
		tableView?.delegate = self
		tableView?.dataSource = self
		output = PresenterUser()
		output?.viewController = self
		output?.wireFrame = RouterToDetailUserController()
		let interactor: InteractorUser = InteractorUser()
		output?.interactor = interactor
		output?.updateModels()
		allViewModel = output!.getAllUserViewModels()
	}

	override func viewWillAppear(_ animated: Bool) {
		viewModel = output!.createDictionary()
		keys = Array(viewModel!.keys)
		keys?.sort{$0 < $1}

		tableView?.reloadData()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension ViewControllerPrepod: UITableViewDelegate {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 90
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return keys?[section]
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let object = viewModel![Constants.objectOfCourse[indexPath.section]]![indexPath.row]
		var indexOut = 0
		for index in 0 ..< allViewModel.count {
			if allViewModel[index].adress == object.adress &&
				allViewModel[index].firstName == object.firstName &&
				allViewModel[index].lastName == object.lastName {
				indexOut = index
			}
		}
		let _ = output?.interactor?.updateModels() 
		output?.callDetailViewController(myIndexPath: NSIndexPath.init(row: indexOut, section: 0))
	}
}

extension ViewControllerPrepod: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return keys?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel![keys![section]]?.count ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: VDMyCell.cellIdentifier, for: indexPath) as? VDMyCell
		guard let cellIn = cell else { return UITableViewCell() }
		cellIn.configureCell(withObject: viewModel![keys![indexPath.section]]![indexPath.row])
		return cellIn
	}
}

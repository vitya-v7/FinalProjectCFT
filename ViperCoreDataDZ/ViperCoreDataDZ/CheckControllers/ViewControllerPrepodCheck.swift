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
	var viewModels = [IListViewModel]()
	var output: PresenterGeneralCheck?
	var prepodIndex: NSInteger = -1
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView?.dataSource = self
		self.tableView?.delegate = self
		let nib = UINib.init(nibName: VDMyCell.nibName, bundle: nil)
		tableView?.register(nib, forCellReuseIdentifier: VDMyCell.cellIdentifier)
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

		tableView?.reloadData()
	}
}

extension ViewControllerPrepodCheck: UITableViewDelegate {
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

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
	{
		return 90
	}
}

extension ViewControllerPrepodCheck: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModels.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: VDMyCell.cellIdentifier, for: indexPath) as? VDMyCell
		guard let cellIn = cell else { return UITableViewCell() }
		cellIn.configureCell(withObject: viewModels[indexPath.row] as! UserViewModel)
		return cellIn
	}
}


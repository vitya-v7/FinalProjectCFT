//
//  ViewController.swift
//  VDDZCoreData
//
//  Created by Admin on 28.11.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDelegate  {

	var info = ["1","2","3","4","5"]
	internal var identifier = "UserCell"
	var dataSource = CustomDataSourse()

	@IBOutlet var tableView: UITableView?


	override func viewDidLoad() {
		super.viewDidLoad()



		var nib = UINib.init(nibName: "userDescriptionCell", bundle: nil)
		self.tableView?.register(nib, forCellReuseIdentifier: "UserCell")
		nib = UINib.init(nibName: "courseDescriptionCell", bundle: nil)
		self.tableView?.register(nib, forCellReuseIdentifier: "CourseCell")
		tableView?.delegate = self
		tableView?.dataSource = dataSource
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func viewDidLayoutSubviews() {

		super.viewDidLayoutSubviews()

	}

	func setNewCells(cells:[String:[configuringCell]], keys: [String]) {

	}

	

	func createDict() -> [String: [Special]] {

		return [:]
	}

	@objc func myEditing( but: UIBarButtonItem) {
		var but :UIBarButtonItem
		if (self.tableView?.isEditing == false) {
			self.tableView?.isEditing = true
			but = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(myEditing(but:)))

		}
		else {
			self.tableView?.isEditing = false
			but = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(myEditing(but:)))
		}
		self.navigationItem.leftBarButtonItem = but

	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
	{
		return 90
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	/////////////////////////////////////////////////


	var managedObjectContext: NSManagedObjectContext? {
		get {
			return VDDataManager.sharedManager.persistentContainer.viewContext
		}
	}

	// MARK: - Segues

	// MARK: - Table View

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return 0
	}

	// MARK: - Fetched results controller

	func configureCell(_ cell: UITableViewCell, withObject object: VDUserSpecial) {

	}

}


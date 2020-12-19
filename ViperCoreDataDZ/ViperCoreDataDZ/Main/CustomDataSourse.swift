//
//  CustomDataSourse.swift
//  VDDZCoreData
//
//  Created by Admin on 09.12.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import CoreData
enum cellType {
	case user
	case course
}

class CustomDataSourse: NSObject, UITableViewDataSource {

	var sourceDictionary: [String: [configuringCell]] = [:]
	var keys: [String] = []

	
	func setDataDictionary( data: [String: [configuringCell]], keys:[String])
	{
		sourceDictionary = data
		self.keys = keys

	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
	{
		// Return false if you do not want the specified item to be editable.
		return true
	}
	
	func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
	{
		return .delete
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return keys[section]
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		return sourceDictionary[keys[indexPath.section]]![indexPath.row] as! UITableViewCell
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return sourceDictionary.keys.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{

		return sourceDictionary[keys[section]]?.count ?? 0
	}
	
}

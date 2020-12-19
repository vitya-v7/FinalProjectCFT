//
//  InteractorListProtocol.swift
//  ViperCoreDataDZ
//
//  Created by Admin on 20.12.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import CoreData
protocol InteractorUserListProtocol {
	func updateDataBase()
	func createDict() -> [String: [Special]]
	func getData(updateCell:(_ data:[String:[Special]])->())
	func addEmptyUser() -> NSManagedObjectID
	func getUserByID( id: NSManagedObjectID) -> VDUserSpecial
	func deleteObjectWithIDFromDB(id: NSManagedObjectID)
	
}

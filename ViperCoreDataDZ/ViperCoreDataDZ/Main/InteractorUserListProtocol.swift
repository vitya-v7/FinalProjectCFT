//
//  InteractorListProtocol.swift
//  ViperCoreDataDZ
//
//  Created by Андрей Белкин on 03.08.17.
//  Copyright © 2017 Viktor Deryabin. All rights reserved.
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

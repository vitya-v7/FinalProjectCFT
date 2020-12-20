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
	func addEmptyUser() -> VDUserSpecial
	func getUserByID( id: NSManagedObjectID) -> VDUserSpecial
	func deleteObjectFromDB(object: VDUserSpecial)
	func returnData() -> [VDUserSpecial]
	func getData(getUsers:([VDUserSpecial])->())
}


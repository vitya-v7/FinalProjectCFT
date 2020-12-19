//
//  InteractorUser.swift
//  ViperCoreDataDZ
//
//  Created by Admin on 16.12.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import CoreData
class InteractorUser: NSObject, InteractorUserListProtocol {
	
	func updateDataBase() {
    	VDDataManager.sharedManager.updateUserBD()
    	VDDataManager.sharedManager.updateCourseBD()
	}
	func createDict() -> [String: [Special]]{
    	return ["Users":VDUserSpecial.users]
	}
	func getData(updateCell:(_ data:[String:[Special]])->()) {
    	
    	updateCell(createDict())
	}
	func addEmptyUser() -> NSManagedObjectID {
    	return VDDataManager.sharedManager.addEmptyUser()
	}
	func getUserByID( id: NSManagedObjectID) -> VDUserSpecial{
    	return VDUserSpecial.users[VDUserSpecial.getUserIndexByID(id: id)!]
	}
	func deleteObjectWithIDFromDB(id: NSManagedObjectID) {
    	VDDataManager.sharedManager.deleteByID(id: id)
	}
	
	
}

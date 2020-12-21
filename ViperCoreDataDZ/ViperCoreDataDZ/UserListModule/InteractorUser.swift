//
//  InteractorUser.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 16.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData

protocol InteractorUserListProtocol {
	func updateDataBase()
	func addEmptyUser() -> VDUserSpecial
	func deleteObjectFromDB(object: VDUserSpecial)
	func returnData() -> [VDUserSpecial]
	func getData(getUsers:([VDUserSpecial])->())
}

class InteractorUser: NSObject, InteractorUserListProtocol {
	var users = [VDUserSpecial]()
	func updateDataBase() {
		VDDataManager.sharedManager.updateUserBD()
		VDDataManager.sharedManager.updateCourseBD()
	}
	func returnData() -> [VDUserSpecial]{
		users = VDUserSpecial.users
		users.sortingBy(parameters: ["firstName", "lastName"])
		return users
	}

	func getData(getUsers:([VDUserSpecial])->()) {
		getUsers(returnData())
	}
	func addEmptyUser() -> VDUserSpecial {
		return VDDataManager.sharedManager.addEmptyUser()
	}
	
	func deleteObjectFromDB(object: VDUserSpecial) {
		guard let id = object.ID else {
			return
		}
		VDDataManager.sharedManager.deleteByID(id: id)
	}
}

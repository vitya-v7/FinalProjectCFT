//
//  InteractorListProtocol.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 20.12.2020.
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


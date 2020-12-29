//
//  Special.swift
//  VDDZCoreData
//
//  Created by Viktor Deryabin on 08.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData
protocol compareTwoElements {
	func compareTwoElements(i2: compareTwoElements, ByParameter parameter: String) -> Bool?
	subscript(string:String) -> String? { get }
}

class Special: NSObject, compareTwoElements {
	var ID:NSManagedObjectID?
	func compareTwoElements(i2: compareTwoElements, ByParameter parameter: String) -> Bool? {
		if let i22 = i2[parameter]?.capitalized, let i11 = self[parameter]?.capitalized {
			if (i22 > i11) {
				return true
			}
			if (i22 == i11) {
				return nil
			}
		}
		return false
	}
	subscript (string:String) -> String? {
		return nil
	}
}





//
//  Special.swift
//  VDDZCoreData
//
//  Created by Андрей Белкин on 22.07.17.
//  Copyright © 2017 Viktor Deryabin. All rights reserved.
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
    	if let i22 = i2[parameter], let i11 = self[parameter] {
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

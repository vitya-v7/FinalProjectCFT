//
//  Sorting.swift
//  VDDZCoreData
//
//  Created by Admin on 08.12.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

extension Array where Element: compareTwoElements{
	
	mutating func sortingBy(parameters:[String]) {
    	var bool: Bool?
	    	self.sort(by: { (i1, i2) -> Bool in
    	    	for index in 0 ..< parameters.count
	    	    	{
    	    	    	bool = i1.compareTwoElements(i2: i2, ByParameter: parameters[index])
    	    	    	
	    	    	if bool == nil
    	    	    	{
	    	    	    	continue
    	    	    	}
	    	    	return bool!
    	    	}
    	    	return true
	    	})
	}
}

//
//  UserDetailViewModel.swift
//  ViperCoreDataDZ
//
//  Created by Admin on 21.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import Foundation

class UserDetailViewModel {
	var adress: String
	var firstName: String
	var lastName: String
	init(adress: String, firstName: String, lastName: String) {
		self.adress = adress
		self.firstName = firstName
		self.lastName = lastName
	}
	init() {}
}

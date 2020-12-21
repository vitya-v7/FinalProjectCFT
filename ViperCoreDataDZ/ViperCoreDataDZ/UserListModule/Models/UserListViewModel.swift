//
//  UserListViewModel.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 20.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import Foundation

class UserListViewModel {
	var adress: String
	var firstName: String
	var lastName: String
	var textFieldTag: Int?

	init(adress: String, firstName: String, lastName: String) {
		self.adress = adress
		self.firstName = firstName
		self.lastName = lastName
	}

	init() {
		self.adress = ""
		self.firstName = ""
		self.lastName = ""
	}
}

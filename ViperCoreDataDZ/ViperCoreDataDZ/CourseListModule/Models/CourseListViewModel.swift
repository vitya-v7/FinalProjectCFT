//
//  CourseListViewModel.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 20.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import Foundation

class CourseListViewModel: IListViewModel {
	var name: String
	var prepod: String
	var predmet: String
	init(name: String, prepod: String, predmet: String) {
		self.name = name
		self.prepod = prepod
		self.predmet = predmet
	}
}

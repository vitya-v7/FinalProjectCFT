//
//  ViewController.swift
//  VDDZCoreData
//
//  Created by Viktor Deryabin on 28.11.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData


protocol IListViewController: UIViewController {

	func setViewModels(viewModels: [IListViewModel])
	func updateViewModels()
}


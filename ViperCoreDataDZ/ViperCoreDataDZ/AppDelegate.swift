//
//  AppDelegate.swift
//  ViperCoreDataDZ
//
//  Created by Viktor Deryabin on 16.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		/*VDDataManager.sharedManager.deleteAllObjects(WithEntityName: "VDUser")
		VDDataManager.sharedManager.deleteAllObjects(WithEntityName: "VDCourse")
		VDDataManager.sharedManager.addTenUsers()
		VDDataManager.sharedManager.addTenCourses()*/

		return true
	}
}


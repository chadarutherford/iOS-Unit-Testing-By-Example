//
//  TestingAppDelegate.swift
//  AppLaunchTests
//
//  Created by Chad Rutherford on 9/24/20.
//

import UIKit

@objc(TestingAppDelegate)
class TestingAppDelegate: UIResponder, UIApplicationDelegate {



	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		print(">> Launching with testing app delegate")
		return true
	}
}

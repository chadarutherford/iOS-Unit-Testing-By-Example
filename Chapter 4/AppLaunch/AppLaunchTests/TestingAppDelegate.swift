//
//  TestingAppDelegate.swift
//  AppLaunchTests
//
//  Created by Chad Rutherford on 9/24/20.
//

import UIKit

@objc(TestingAppDelegate)
final class TestingAppDelegate: UIResponder, UIApplicationDelegate {
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		for sceneSession in application.openSessions {
			application.perform(Selector(("_removeSessionFromSessionSet:")), with: sceneSession)
		}
		return true
	}
	
	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when new scene session is being created
		// Use this method to select a configuration to create the new scene with
		let sceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
		sceneConfiguration.delegateClass = TestingSceneDelegate.self
		return sceneConfiguration
	}
}

//
//  TestingSceneDelegate.swift
//  AppLaunchTests
//
//  Created by Chad Rutherford on 9/24/20.
//

import UIKit

class TestingSceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = scene as? UIWindowScene else { return }
		window = UIWindow(windowScene: windowScene)
		window?.rootViewController = TestingRootViewController(nibName: nil, bundle: nil)
		window?.makeKeyAndVisible()
	}
}

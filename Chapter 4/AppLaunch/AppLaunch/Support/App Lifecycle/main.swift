//
//  main.swift
//  AppLaunch
//
//  Created by Chad Rutherford on 9/24/20.
//

import UIKit

let appDelegateClass: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self
UIApplicationMain(
	CommandLine.argc,
	CommandLine.unsafeArgv,
	nil,
	NSStringFromClass(appDelegateClass))

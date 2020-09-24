//
//  MySingletonAnalytics.swift
//  HardDependencies
//
//  Created by Chad Rutherford on 9/24/20.
//

import Foundation

class MySingletonAnalytics {
	static let shared = MySingletonAnalytics()
	
	func track(event: String) {
		Analytics.shared.track(event: event)
		
		if self !== MySingletonAnalytics.shared {
			print(">> Not the MySingletonAnalytics singleton")
		}
	}
}

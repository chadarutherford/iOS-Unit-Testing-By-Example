//
//  Analytics.swift
//  HardDependencies
//
//  Created by Chad Rutherford on 9/24/20.
//

import Foundation

class Analytics {
	static let shared = Analytics()
	
	func track(event: String) {
		print(">> " + event)
		
		if self !== Analytics.shared {
			print(">> ...Not the Analytics singleton")
		}
	}
}

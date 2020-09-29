//
//  MockUserDefaults.swift
//  UserDefaultsTests
//
//  Created by Chad Rutherford on 9/25/20.
//

import Foundation
@testable import UserDefaults

class MockUserDefaults: UserDefaultsProtocol {
	
	var integers = [String: Int]()
	
	func set(_ value: Int, forKey defaultName: String) {
		integers[defaultName] = value
	}
	
	func integer(forKey defaultName: String) -> Int {
		integers[defaultName] ?? 0
	}
}

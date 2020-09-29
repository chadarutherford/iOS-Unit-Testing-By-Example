//
//  UserDefaultsProtocol.swift
//  UserDefaults
//
//  Created by Chad Rutherford on 9/25/20.
//

import Foundation

protocol UserDefaultsProtocol {
	func set(_ value: Int, forKey defaultName: String)
	func integer(forKey defaultName: String) -> Int
}

extension UserDefaults: UserDefaultsProtocol {
	
}

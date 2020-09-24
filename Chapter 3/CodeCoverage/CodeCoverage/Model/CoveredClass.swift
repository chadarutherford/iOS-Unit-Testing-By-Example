//
//  CoveredClass.swift
//  CodeCoverage
//
//  Created by Chad Rutherford on 9/24/20.
//

import UIKit

class CoveredClass {
	static func max(_ x: Int, _ y: Int) -> Int {
		// terniary to determine better code coverage
		return x < y ? y : x
		// Branching strategy to visualize code coverage
//		if x < y {
//			return y
//		} else {
//			return x
//		}
	}
}

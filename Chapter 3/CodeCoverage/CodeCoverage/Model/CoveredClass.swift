//
//  CoveredClass.swift
//  CodeCoverage
//
//  Created by Chad Rutherford on 9/24/20.
//

import UIKit

class CoveredClass {
	static func max(_ x: Int, _ y: Int) -> Int {
		if x < y {
			return y
		} else {
			return x
		}
	}
}

//
//  CoveredClassTests.swift
//  CodeCoverageTests
//
//  Created by Chad Rutherford on 9/24/20.
//

import XCTest
@testable import CodeCoverage

class CoveredClassTests: XCTestCase {
	
	func test_max_with1And2_shouldReturnSomething() {
		let result = CoveredClass.max(1, 2)
	}
}

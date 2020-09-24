//
//  CoveredClassTests.swift
//  CodeCoverageTests
//
//  Created by Chad Rutherford on 9/24/20.
//

import XCTest
@testable import CodeCoverage

class CoveredClassTests: XCTestCase {
	
	func test_max_with1And2_shouldReturn2() {
		let result = CoveredClass.max(1, 2)
		XCTAssertEqual(result, 2)
	}
	
	func test_max_with3And2_shouldReturn3() {
		let result = CoveredClass.max(3, 2)
		XCTAssertEqual(result, 3)
	}
}

//
//  CodeBasedViewControllerTests.swift
//  LoadViewControllersProgTests
//
//  Created by Chad Rutherford on 9/24/20.
//

import XCTest
@testable import LoadViewControllersProg

class CodeBasedViewControllerTests: XCTestCase {
	
	func test_loading() {
		let sut = CodeBasedViewController(data: "DUMMY")
		sut.loadViewIfNeeded()
	}
}

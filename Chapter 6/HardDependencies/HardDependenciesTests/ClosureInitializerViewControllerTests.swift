//
//  ClosureInitializerViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by Chad Rutherford on 9/24/20.
//

import XCTest
@testable import HardDependencies

class ClosureInitializerViewControllerTests: XCTestCase {
	
	func test_viewDidAppear() {
		let sut = ClosureInitializerViewController { Analytics() }
		sut.loadViewIfNeeded()
		sut.viewDidAppear(false)
	}
}

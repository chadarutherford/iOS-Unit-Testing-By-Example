//
//  InstanceInitializerViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by Chad Rutherford on 9/24/20.
//

import XCTest
@testable import HardDependencies

class InstanceInitializerViewControllerTests: XCTestCase {
	func test_viewDidAppear() {
		let sut = InstanceInitializerViewController(analytics: Analytics())
		sut.loadViewIfNeeded()
		sut.viewDidAppear(false)
	}
}

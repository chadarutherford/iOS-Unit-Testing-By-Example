//
//  OverrideViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by Chad Rutherford on 9/24/20.
//

import XCTest
@testable import HardDependencies

class OverrideViewControllerTests: XCTestCase {
	
	private class TestableOverrideViewController: OverrideViewController {
		override func analytics() -> Analytics {
			Analytics()
		}
	}
	
	func test_viewDidAppear() {
		let sut = TestableOverrideViewController(nibName: nil, bundle: nil)
		sut.loadViewIfNeeded()
		sut.viewDidAppear(false)
	}
}

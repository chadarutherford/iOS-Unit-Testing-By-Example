//
//  MySingletonViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by Chad Rutherford on 9/24/20.
//

import XCTest
@testable import HardDependencies

class MySingletonViewControllerTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		MySingletonAnalytics.stubbedInstance = MySingletonAnalytics()
	}
	
	func test_viewDidAppear() {
		let sut = MySingletonViewController(nibName: String(describing: MySingletonViewController.self), bundle: nil)
		sut.loadViewIfNeeded()
		sut.viewDidAppear(false)
	}
	
	override func tearDown() {
		MySingletonAnalytics.stubbedInstance = nil
		super.tearDown()
	}
}

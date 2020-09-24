//
//  XIBBasedViewControllerTests.swift
//  LoadViewControllersXIBTests
//
//  Created by Chad Rutherford on 9/24/20.
//

import XCTest
@testable import LoadViewControllersXIB

class XIBBasedViewControllerTests: XCTestCase {
	
	func test_loading() {
		let sut = XIBBasedViewController(nibName: String(describing: XIBBasedViewController.self), bundle: nil)
		sut.loadViewIfNeeded()
		XCTAssertNotNil(sut.label)
	}
}

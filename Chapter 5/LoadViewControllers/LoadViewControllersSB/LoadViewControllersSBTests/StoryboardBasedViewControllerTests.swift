//
//  StoryboardBasedViewControllerTests.swift
//  LoadViewControllersSBTests
//
//  Created by Chad Rutherford on 9/24/20.
//

import XCTest
@testable import LoadViewControllersSB

class StoryboardBasedViewControllerTests: XCTestCase {
	
	func test_loading() {
		let sb = UIStoryboard(name: "Main", bundle: nil)
		let sut: StoryboardBasedViewController = sb.instantiateViewController(identifier: String(describing: StoryboardBasedViewController.self))
		sut.loadViewIfNeeded()
		XCTAssertNotNil(sut.label)
	}
}

//
//  OutletConnectionsViewControllerTests.swift
//  OutletConnectionsTests
//
//  Created by Chad Rutherford on 9/24/20.
//

import XCTest
@testable import OutletConnections

class OutletConnectionsViewControllerTests: XCTestCase {
	
	func test_outlets_shouldBeConnected() {
		let sut = OutletConnectionsViewController()
		sut.loadViewIfNeeded()
		XCTAssertNotNil(sut.label, "label")
		XCTAssertNotNil(sut.button, "button outlet is nil")
	}
}

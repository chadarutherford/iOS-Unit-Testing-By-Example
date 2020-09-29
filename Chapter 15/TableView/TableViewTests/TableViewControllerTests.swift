//
//  TableViewControllerTests.swift
//  TableViewTests
//
//  Created by Chad Rutherford on 9/29/20.
//

import XCTest
@testable import TableView

class TableViewControllerTests: XCTestCase {
	
	private var sut: TableViewController!
	
	override func setUp() {
		super.setUp()
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewController(identifier: String(describing: TableViewController.self))
	}
	
	func test_tableViewDelegates_shouldBeConnected() {
		XCTAssertNotNil(sut.tableView.dataSource, "dataSource")
		XCTAssertNotNil(sut.tableView.delegate, "delegate")
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}

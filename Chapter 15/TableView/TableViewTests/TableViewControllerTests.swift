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
		sut.loadViewIfNeeded()
	}
	
	func test_tableViewDelegates_shouldBeConnected() {
		XCTAssertNotNil(sut.tableView.dataSource, "dataSource")
		XCTAssertNotNil(sut.tableView.delegate, "delegate")
	}
	
	func test_numberOfRows_shouldBe3() {
		XCTAssertEqual(numberOfRows(in: sut.tableView), 3)
	}
	
	func test_cellForRowAt_withRow0_shouldSetCellLabelToOne() {
		let cell = cellForRow(in: sut.tableView, row: 0)
		XCTAssertEqual(cell?.textLabel?.text, "One")
	}
	
	func test_cellForRowAt_withRow1_shouldSetCellLabelToTwo() {
		let cell = cellForRow(in: sut.tableView, row: 1)
		XCTAssertEqual(cell?.textLabel?.text, "Two")
	}
	
	func test_cellForRowAt_withRow2_shouldSetCellLabelToThree() {
		let cell = cellForRow(in: sut.tableView, row: 2)
		XCTAssertEqual(cell?.textLabel?.text, "Three")
	}
	
	func test_didSelectRow_withRow1() {
		didSelectRow(in: sut.tableView, row: 1)
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}

//
//  GreeterWithoutNameTests.swift
//  TDDTests
//
//  Created by Chad Rutherford on 9/30/20.
//

import XCTest
@testable import TDD

class GreeterWithoutNameTests: XCTestCase {
	
	private var sut: Greeter!
	
	override func setUp() {
		super.setUp()
		sut = Greeter(name: "")
	}
	
	func test_greet_with1159am_shouldSayGoodMorning() {
		let result = sut.greet(time: date(hour: 11, minute: 59))
		XCTAssertEqual(result, "Good morning.")
	}
	
	func test_greet_with1200pm_shouldSayGoodAfternoon() {
		let result = sut.greet(time: date(hour: 12, minute: 00))
		XCTAssertEqual(result, "Good afternoon.")
	}
	
	func test_greet_with459pm_shouldSayGoodAfternoon() {
		let result = sut.greet(time: date(hour: 16, minute: 59))
		XCTAssertEqual(result, "Good afternoon.")
	}
	
	func test_greet_with200pm_shouldSayGoodAfternoon() {
		let result = sut.greet(time: date(hour: 14, minute: 00))
		XCTAssertEqual(result, "Good afternoon.")
	}
	
	func test_greet_with500pm_shouldSayGoodEvening() {
		let result = sut.greet(time: date(hour: 17, minute: 00))
		XCTAssertEqual(result, "Good evening.")
	}
	
	func test_greet_with1159pm_shouldSayGoodEvening() {
		let result = sut.greet(time: date(hour: 23, minute: 59))
		XCTAssertEqual(result, "Good evening.")
	}
	
	func test_greet_with800pm_shouldSayGoodEvening() {
		let result = sut.greet(time: date(hour: 20, minute: 00))
		XCTAssertEqual(result, "Good evening.")
	}
	
	func test_greet_with1200am_shouldSayGoodEvening() {
		let result = sut.greet(time: date(hour: 0, minute: 00))
		XCTAssertEqual(result, "Good evening.")
	}
	
	func test_greet_with459am_shouldSayGoodEvening() {
		let result = sut.greet(time: date(hour: 4, minute: 59))
		XCTAssertEqual(result, "Good evening.")
	}
	
	func test_greet_with200am_shouldSayGoodEvening() {
		let result = sut.greet(time: date(hour: 2, minute: 00))
		XCTAssertEqual(result, "Good evening.")
	}
	
	func test_greet_with500am_shouldSayGoodMorning() {
		let result = sut.greet(time: date(hour: 5, minute: 00))
		XCTAssertEqual(result, "Good morning.")
	}
	
	func test_greet_with800am_shouldSayGoodMorning() {
		let result = sut.greet(time: date(hour: 8, minute: 00))
		XCTAssertEqual(result, "Good morning.")
	}
	
	private func date(hour: Int, minute: Int) -> Date {
		let components = DateComponents(calendar: Calendar.current, hour: hour, minute: minute)
		return components.date!
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}

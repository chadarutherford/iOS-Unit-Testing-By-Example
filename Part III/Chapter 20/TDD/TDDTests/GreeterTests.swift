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
	
	private func date(hour: Int, minute: Int) -> Date {
		let components = DateComponents(calendar: Calendar.current, hour: hour, minute: minute)
		return components.date!
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}

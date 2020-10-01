//
//  GreeterTests.swift
//  TDDTests
//
//  Created by Chad Rutherford on 9/30/20.
//

import XCTest
@testable import TDD

class GreeterTests: XCTestCase {
	
	func test_greet_with1159am_shouldSayGoodMorning() {
		let sut = Greeter(name: "")
		let result = sut.greet(time: date(hour: 11, minute: 59))
		XCTAssertEqual(result, "Good morning")
	}
	
	private func date(hour: Int, minute: Int) -> Date {
		let components = DateComponents(calendar: Calendar.current, hour: hour, minute: minute)
		return components.date!
	}
}

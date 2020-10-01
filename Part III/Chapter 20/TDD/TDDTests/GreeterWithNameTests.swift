//
//  GreeterWithNameTests.swift
//  TDDTests
//
//  Created by Chad Rutherford on 9/30/20.
//

import XCTest
@testable import TDD

final class GreeterWithNameTests: XCTestCase {
	
	func test_greetMorning_withAlberto_shouldSayGoodMorningAlberto() {
		let sut = Greeter(name: "Alberto")
		let result = sut.greet(time: date(hour: 5, minute: 00))
		XCTAssertEqual(result, "Good morning, Alberto.")
	}
	
	func test_greetAfternoon_withBeryl_shouldSayGoodAfternoonBeryl() {
		let sut = Greeter(name: "Beryl")
		let result = sut.greet(time: date(hour: 15, minute: 00))
		XCTAssertEqual(result, "Good afternoon, Beryl.")
	}
}

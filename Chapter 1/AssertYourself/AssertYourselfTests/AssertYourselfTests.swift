//
//  AssertYourselfTests.swift
//  AssertYourselfTests
//
//  Created by Chad Rutherford on 9/24/20.
//

import XCTest

class AssertYourselfTests: XCTestCase {
	// Failing test with failure message
	func test_fail() {
		XCTFail("We have a problem")
	}

	// Failing test with interpolated message
	func test_fail_withInterpolatedMessage() {
		let theAnswer = 42
		XCTFail("The answer to the Great Question is \(theAnswer)")
	}
	
	// Test without if conditionals removes unnecessary code and make code easier to read
	func test_assertTrue() {
		let success = false
		XCTAssertTrue(success)
	}
	
	// Testing for nil
	func test_assertNil() {
		let optionalValue: Int? = 123
		XCTAssertNil(optionalValue)
	}
	
	// Same test with a struct to report actual contents not a string
	struct SimpleStruct: CustomStringConvertible {
		let x: Int
		let y: Int
	}
	
	func test_assertNil_withSimpleStruct() {
		let optionalValue: SimpleStruct? = SimpleStruct(x: 1, y: 2)
		XCTAssertNil(optionalValue)
	}
	
	// Same test with a struct and description to report actual contents not a string
	struct StructWithDescription: CustomStringConvertible {
		let x: Int
		let y: Int

		var description: String { "(\(x), \(y))"}
	}

	func test_assertNil_withSelfDescribingType() {
		let optionalValue: StructWithDescription? = StructWithDescription(x: 1, y: 2)
		XCTAssertNil(optionalValue)
	}
	
	// Testing for equality
	func test_assertEqual() {
		let actual = "actual"
		XCTAssertEqual(actual, "expected")  // XCTAssertEqual failed: ("actual") is not equal to ("expected")
	}
	
	// Testing for equality with optionals
	func test_assertEqual_withOptional() {
		let result : String? = "foo"
		XCTAssertEqual(result, "bar") // XCTAssertEqual failed: ("Optional("foo")") is not equal to ("Optional("bar")")
	}
	
	// Testing for equality with floats
	func test_floatingPointDanger() {
		let result = 0.1 + 0.2
		XCTAssertEqual(result, 0.3)
	}
	
	// Passing double test by providing an accuracy buffer
	func test_floatingPointFixed() {
		let result = 0.1 + 0.2
		XCTAssertEqual(result, 0.3, accuracy: 0.0001)
	}
	
	// Providing redundant messages - AVOID
	func test_messageOverkill() {
		let actual = "actual"
		XCTAssertEqual(actual, "expected", "Expected \"expected\" but got \"\(actual)\"")
	}
}

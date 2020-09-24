//
//  MyClassTests.swift
//  LifeCycleTests
//
//  Created by Chad Rutherford on 9/24/20.
//

import XCTest
@testable import LifeCycle

class MyClassTests: XCTestCase {
	
	// Test Zero
//	func test_zero() {
//		XCTFail("Tests not yet implemented in MyClassTests")
//	}
	
	private var sut: MyClass!
	
	override func setUp() {
		super.setUp()
		sut = MyClass()
	}
	
	func test_methodOne() {
		sut.methodOne()
	}
	
	func test_methodTwo() {
		sut.methodTwo()
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}

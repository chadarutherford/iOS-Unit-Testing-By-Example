//
//  ViewControllerTests.swift
//  UserDefaultsTests
//
//  Created by Chad Rutherford on 9/25/20.
//

import XCTest
@testable import UserDefaults

class ViewControllerTests: XCTestCase {
	
	private var sut: ViewController!
	private var userDefaults: MockUserDefaults!
	
	override func setUp() {
		super.setUp()
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
		userDefaults = MockUserDefaults()
		sut.userDefaults = userDefaults
	}
	
	func test_viewDidLoad_withEmptyUserDefaults_shouldShow0InCounterLabel() {
		sut.loadViewIfNeeded()
		XCTAssertEqual(sut.counterLabel.text, "0", "counter label")
	}
	
	func test_viewDidLoad_with7InUserDefaults_shouldShow7InCounterLabel() {
		userDefaults.integers = ["count": 7]
		sut.loadViewIfNeeded()
		XCTAssertEqual(sut.counterLabel.text, "7", "counter label")
	}
	
	func test_tappingButton_with12InUserDefaults_shouldWrite13ToUserDefaults() {
		userDefaults.integers = ["count": 12]
		sut.loadViewIfNeeded()
		sut.incrementButton.tap()
		XCTAssertEqual(userDefaults.integers["count"], 13)
	}
	
	func test_tappingButton_with42InUserDefaults_shouldShow43InCounterLabel() {
		userDefaults.integers = ["count": 42]
		sut.loadViewIfNeeded()
		sut.incrementButton.tap()
		XCTAssertEqual(sut.counterLabel.text, "43")
	}
	
	override func tearDown() {
		sut = nil
		userDefaults = nil
		super.tearDown()
	}
}

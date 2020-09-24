//
//  ViewControllerTests.swift
//  ButtonTapTests
//
//  Created by Chad Rutherford on 9/24/20.
//

import XCTest
@testable import ButtonTap

class ViewControllerTests: XCTestCase {
	
	func test_tappingButton() {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
		sut.loadViewIfNeeded()
	}
}

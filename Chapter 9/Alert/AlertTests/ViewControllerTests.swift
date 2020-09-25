//
//  ViewControllerTests.swift
//  AlertTests
//
//  Created by Chad Rutherford on 9/24/20.
//

import ViewControllerPresentationSpy
import XCTest
@testable import Alert

class ViewControllerTests: XCTestCase {
	
	private var alertVerifier: AlertVerifier!
	
	override func setUp() {
		super.setUp()
		alertVerifier = AlertVerifier()
	}
	
	func test_buttonTap_shouldShowAlert() {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
		sut.loadViewIfNeeded()
		sut.button.tap()
		alertVerifier.verify(
			title: "Do the Thing?",
			message: "Let us know if you want to do the thing",
			animated: true,
			actions: [
				.cancel("Cancel"),
				.default("OK"),
			],
			presentingViewController: sut
		)
		XCTAssertEqual(alertVerifier.preferredAction?.title, "OK", "preferred action")
	}
	
	override func tearDown() {
		alertVerifier = nil
		super.tearDown()
	}
}

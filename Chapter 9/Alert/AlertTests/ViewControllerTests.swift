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
	
	private var sut: ViewController!
	private var alertVerifier: AlertVerifier!
	
	override func setUp() {
		super.setUp()
		alertVerifier = AlertVerifier()
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
		sut.loadViewIfNeeded()
	}
	
	func test_buttonTap_shouldShowAlert() {
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
	
	func test_executeAlertAction_withOKButton() throws {
		sut.button.tap()
		try alertVerifier.executeAction(forButton: "OK")
	}
	
	func test_executeAlertAction_withCancelButton() throws {
		sut.button.tap()
		try alertVerifier.executeAction(forButton: "Cancel")
	}
	
	override func tearDown() {
		alertVerifier = nil
		sut = nil
		super.tearDown()
	}
}

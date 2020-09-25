//
//  ViewControllerTests.swift
//  TextFieldTests
//
//  Created by Chad Rutherford on 9/25/20.
//

import XCTest
@testable import TextField

class ViewControllerTests: XCTestCase {
	
	private var sut: ViewController!
	
	override func setUp() {
		super.setUp()
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
		sut.loadViewIfNeeded()
	}
	
	func test_outlets_shouldBeConnected() {
		XCTAssertNotNil(sut.userNameField, "usernameField")
		XCTAssertNotNil(sut.passwordField, "passwordField")
	}
	
	func test_usernameField_attributesShouldBeSet() {
		let textField = sut.userNameField!
		XCTAssertEqual(textField.textContentType, .username, "textContentType")
		XCTAssertEqual(textField.autocorrectionType, .no, "autocorrectionType")
		XCTAssertEqual(textField.returnKeyType, .next, "returnKeyType")
	}
	
	func test_passwordField_attributesShouldBeSet() {
		let textField = sut.passwordField!
		XCTAssertEqual(textField.textContentType, .password, "textContentType")
		XCTAssertEqual(textField.returnKeyType, .go, "returnKeyType")
		XCTAssertTrue(textField.isSecureTextEntry, "isSecureTextEntry")
	}
	
	func test_textFieldDelegates_shouldBeConnected() {
		XCTAssertNotNil(sut.userNameField.delegate, "userNameFieldDelegate")
		XCTAssertNotNil(sut.passwordField.delegate, "passwordFieldDelegate")
	}
	
	func test_shouldChangeCharacters_usernameWithSpaces_shouldPreventChange​(){
		let allowChange = shouldChangeCharacters(in: sut.userNameField, replacement: "a b")
		XCTAssertEqual(allowChange, false)
	}
	
	func test_shouldChangeCharacters_usernameWithoutSpaces_shouldAllowChange() {
		let allowChange = shouldChangeCharacters(in: sut.userNameField, replacement: "abc")
		XCTAssertEqual(allowChange, true)
	}
	
	func test_shouldChangeCharacters_passwordWithSpaces_shouldAllowChange() {
		let allowChange = shouldChangeCharacters(in: sut.passwordField, replacement: "a b")
		XCTAssertEqual(allowChange, true)
	}
	
	func test_shouldChangeCharacters_passwordWithoutSpaces_shouldAllowChange() {
		let allowChange = shouldChangeCharacters(in: sut.passwordField, replacement: "abc")
		XCTAssertEqual(allowChange, true)
	}
	
	func test_shouldReturn_withPassword_shouldPerformLogin() {
		sut.userNameField.text = "USERNAME"
		sut.passwordField.text = "PASSWORD"
		shouldReturn(in: sut.passwordField)
	}
	
	func test_shouldReturn_withUsername_shouldMoveInputFocusToPassword() {
		putInViewHeirarchy(sut)
		shouldReturn(in: sut.userNameField)
		XCTAssertTrue(sut.passwordField.isFirstResponder)
	}
	
	func test_shouldReturn_withPassword_shouldDismissKeyboard() {
		putInViewHeirarchy(sut)
		sut.passwordField.becomeFirstResponder()
		XCTAssertTrue(sut.passwordField.isFirstResponder, "precondition")
		shouldReturn(in: sut.passwordField)
		XCTAssertFalse(sut.passwordField.isFirstResponder)
	}
	
	override func tearDown() {
		executeRunLoop()
		sut = nil
		super.tearDown()
	}
}

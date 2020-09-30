//
//  ChangePasswordViewControllerTests.swift
//  RefactoringTests
//
//  Created by Chad Rutherford on 9/29/20.
//

import XCTest
@testable import Refactoring

final class ChangePasswordViewControllerTests: XCTestCase {
	
	private var sut: ChangePasswordViewController!
	
	override func setUp() {
		super.setUp()
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewController(identifier: String(describing: ChangePasswordViewController.self))
		sut.loadViewIfNeeded()
	}
	
	func test_outlets_shouldBeConnected() {
		XCTAssertNotNil(sut.cancelBarButton, "cancelButton")
		XCTAssertNotNil(sut.oldPasswordTextField, "oldPassword")
		XCTAssertNotNil(sut.newPasswordTextField, "newPassword")
		XCTAssertNotNil(sut.confirmPasswordTextField, "confirmPassword")
		XCTAssertNotNil(sut.submitButton, "submitButton")
		XCTAssertNotNil(sut.navigationBar, "navigationBar")
	}
	
	func test_navigationBar_shouldHaveTitle() {
		XCTAssertEqual(sut.navigationBar.topItem?.title, "Change Password")
	}
	
	func test_cancelBarButton_shouldBeSystemItemCancel() {
		XCTAssertEqual(systemItem(for: sut.cancelBarButton), .cancel)
	}
	
	func test_oldPasswordTextField_shouldHavePlaceholder() {
		XCTAssertEqual(sut.oldPasswordTextField.placeholder, "Current Password")
	}
	
	func test_newPasswordTextField_shouldHavePlaceholder() {
		XCTAssertEqual(sut.newPasswordTextField.placeholder, "New Password")
	}
	
	func test_confirm_PasswordTextField_shouldHavePlaceholder() {
		XCTAssertEqual(sut.confirmPasswordTextField.placeholder, "Confirm New Password")
	}
	
	func test_submitButton_shouldHaveTitle() {
		XCTAssertEqual(sut.submitButton.titleLabel?.text, "Submit")
	}
	
	func test_oldPasswordTextField_shouldHavePasswordAttributes() {
		let textField = sut.oldPasswordTextField!
		XCTAssertEqual(textField.textContentType, .password, "textContentType")
		XCTAssertTrue(textField.isSecureTextEntry, "isSecureTextEntry")
		XCTAssertTrue(textField.enablesReturnKeyAutomatically, "enablesReturnKeyAutomatically")
	}
	
	func test_newPasswordTextField_shouldHavePasswordAttributes() {
		let textField = sut.newPasswordTextField!
		XCTAssertEqual(textField.textContentType, .newPassword, "textContentType")
		XCTAssertTrue(textField.isSecureTextEntry, "isSecureTextEntry")
		XCTAssertTrue(textField.enablesReturnKeyAutomatically, "enablesReturnKeyAutomatically")
	}
	
	func test_confirmPasswordTextField_shouldHavePasswordAttributes() {
		let textField = sut.confirmPasswordTextField!
		XCTAssertEqual(textField.textContentType, .newPassword, "textContentType")
		XCTAssertTrue(textField.isSecureTextEntry, "isSecureTextEntry")
		XCTAssertTrue(textField.enablesReturnKeyAutomatically, "enablesReturnKeyAutomatically")
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}

//
//  ChangePasswordViewControllerTests.swift
//  RefactoringTests
//
//  Created by Chad Rutherford on 9/29/20.
//

import ViewControllerPresentationSpy
import XCTest
@testable import Refactoring

final class ChangePasswordViewControllerTests: XCTestCase {
	
	private var sut: ChangePasswordViewController!
	private var passwordChanger: MockPasswordChanger!
	private var alertVerifier: AlertVerifier!
	
	override func setUp() {
		super.setUp()
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewController(identifier: String(describing: ChangePasswordViewController.self))
		passwordChanger = MockPasswordChanger()
		sut.passwordChanger = passwordChanger
		alertVerifier = AlertVerifier()
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
	
	func test_tappingCancel_withFocusOnOldPassword_shouldResignThatFocus() {
		putFocusOn(textField: sut.oldPasswordTextField)
		XCTAssertTrue(sut.oldPasswordTextField.isFirstResponder, "precondition")
		tap(sut.cancelBarButton)
		XCTAssertFalse(sut.oldPasswordTextField.isFirstResponder)
	}
	
	func test_tappingCancel_withFocusOnNewPassword_shouldResignThatFocus() {
		putFocusOn(textField: sut.newPasswordTextField)
		XCTAssertTrue(sut.newPasswordTextField.isFirstResponder, "precondition")
		tap(sut.cancelBarButton)
		XCTAssertFalse(sut.newPasswordTextField.isFirstResponder)
	}
	
	func test_tappingCancel_withFocusOnConfirmPassword_shouldResignThatFocus() {
		putFocusOn(textField: sut.confirmPasswordTextField)
		XCTAssertTrue(sut.confirmPasswordTextField.isFirstResponder, "precondition")
		tap(sut.cancelBarButton)
		XCTAssertFalse(sut.confirmPasswordTextField.isFirstResponder)
	}
	
	func test_tappingCancel_shouldDismissModal() {
		let dismissalVerifier = DismissalVerifier()
		tap(sut.cancelBarButton)
		dismissalVerifier.verify(animated: true, dismissedViewController: sut)
	}
	
	
	
	override func tearDown() {
		executeRunLoop()
		sut = nil
		passwordChanger = nil
		alertVerifier = nil
		super.tearDown()
	}
	
	private func putFocusOn(textField: UITextField) {
		putInViewHeirarachy(sut)
		textField.becomeFirstResponder()
	}
}

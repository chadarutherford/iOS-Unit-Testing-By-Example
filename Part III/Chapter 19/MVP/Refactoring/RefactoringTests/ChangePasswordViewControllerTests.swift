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
		sut.viewModel = ChangePasswordViewModel()
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
		putFocusOn(.oldPassword)
		XCTAssertTrue(sut.oldPasswordTextField.isFirstResponder, "precondition")
		tap(sut.cancelBarButton)
		XCTAssertFalse(sut.oldPasswordTextField.isFirstResponder)
	}
	
	func test_tappingCancel_withFocusOnNewPassword_shouldResignThatFocus() {
		putFocusOn(.newPassword)
		XCTAssertTrue(sut.newPasswordTextField.isFirstResponder, "precondition")
		tap(sut.cancelBarButton)
		XCTAssertFalse(sut.newPasswordTextField.isFirstResponder)
	}
	
	func test_tappingCancel_withFocusOnConfirmPassword_shouldResignThatFocus() {
		putFocusOn(.confirmPassword)
		XCTAssertTrue(sut.confirmPasswordTextField.isFirstResponder, "precondition")
		tap(sut.cancelBarButton)
		XCTAssertFalse(sut.confirmPasswordTextField.isFirstResponder)
	}
	
	func test_tappingCancel_shouldDismissModal() {
		let dismissalVerifier = DismissalVerifier()
		tap(sut.cancelBarButton)
		dismissalVerifier.verify(animated: true, dismissedViewController: sut)
	}
	
	func test_tappingSubmit_withOldPasswordEmpty_shouldNotChangePassword() {
		setupValidPasswordEntries()
		sut.oldPasswordTextField.text = ""
		sut.submitButton.tap()
		passwordChanger.verifyChangeNeverCalled()
	}
	
	func test_tappingSubmit_withOldPasswordEmpty_shouldPutFocusOnOldPassword() {
		setupValidPasswordEntries()
		sut.oldPasswordTextField.text = ""
		putInViewHeirarachy(sut)
		sut.submitButton.tap()
		XCTAssertTrue(sut.oldPasswordTextField.isFirstResponder)
	}
	
	func test_tappingSubmit_withNewPasswordEmpty_shouldNotChangePassword() {
		setupValidPasswordEntries()
		sut.newPasswordTextField.text = ""
		sut.submitButton.tap()
		passwordChanger.verifyChangeNeverCalled()
	}
	
	func test_tappingSubmit_withNewPasswordEmpty_shouldShowPasswordBlankAlert() {
		setupValidPasswordEntries()
		sut.newPasswordTextField.text = ""
		sut.submitButton.tap()
		verifyAlertPresented(message: "Please enter a new password.")
	}
	
	func test_tappingOKPasswordBlankAlert_shouldPutFocusOnNewPassword() throws {
		setupValidPasswordEntries()
		sut.newPasswordTextField.text = ""
		sut.submitButton.tap()
		putInViewHeirarachy(sut)
		try alertVerifier.executeAction(forButton: "OK")
		XCTAssertTrue(sut.newPasswordTextField.isFirstResponder)
	}
	
	func test_tappingSubmit_withNewPasswordTooShort_shouldNotChangePassword() {
		setupValidPasswordEntriesTooShort()
		sut.submitButton.tap()
		passwordChanger.verifyChangeNeverCalled()
	}
	
	func test_tappingSubmit_withNewPasswordTooShort_shouldShowTooShortAlert() {
		setupValidPasswordEntriesTooShort()
		sut.submitButton.tap()
		verifyAlertPresented(message: "The new password should have at least 6 characters.")
	}
	
	func test_tappingOKInTooShortAlert_shouldClearNewAndConfirmation() throws {
		setupValidPasswordEntriesTooShort()
		sut.submitButton.tap()
		try alertVerifier.executeAction(forButton: "OK")
		XCTAssertEqual(sut.newPasswordTextField.text?.isEmpty, true, "new")
		XCTAssertEqual(sut.confirmPasswordTextField.text?.isEmpty, true, "confirmation")
	}
	
	func test_tappingOKInTooShortAlert_shouldNotClearOldPasswordField() throws {
		setupValidPasswordEntriesTooShort()
		sut.submitButton.tap()
		try alertVerifier.executeAction(forButton: "OK")
		XCTAssertEqual(sut.oldPasswordTextField.text?.isEmpty, false)
	}
	
	func test_tappingOKInTooShortAlert_shouldPutFocusOnNewPassword() throws {
		setupValidPasswordEntriesTooShort()
		sut.submitButton.tap()
		putInViewHeirarachy(sut)
		try alertVerifier.executeAction(forButton: "OK")
		XCTAssertTrue(sut.newPasswordTextField.isFirstResponder)
	}
	
	func test_tappingSubmit_withConfirmationMismatch_shouldNotChangePassword() {
		setupMismatchedConfirmationEntry()
		sut.submitButton.tap()
		passwordChanger.verifyChangeNeverCalled()
	}
	
	func test_tappingSubmit_withConfirmationMismatch_shouldShowMismatchAlert() {
		setupMismatchedConfirmationEntry()
		sut.submitButton.tap()
		verifyAlertPresented(message: "The new password and the confirmation password don't match. Please try again.")
	}
	
	func test_tappingSubmit_withValidFieldsFocusedOnOldPassword_resignsFocus() {
		setupValidPasswordEntries()
		putFocusOn(.oldPassword)
		XCTAssertTrue(sut.oldPasswordTextField.isFirstResponder, "precondition")
		sut.submitButton.tap()
		XCTAssertFalse(sut.oldPasswordTextField.isFirstResponder)
	}
	
	func test_tappingSubmit_withValidFieldsFocusedOnNewPassword_resignsFocus() {
		setupValidPasswordEntries()
		putFocusOn(.newPassword)
		XCTAssertTrue(sut.newPasswordTextField.isFirstResponder, "precondition")
		sut.submitButton.tap()
		XCTAssertFalse(sut.newPasswordTextField.isFirstResponder)
	}
	
	func test_tappingSubmit_withValidFieldsFocusedOnConfirmPassword_resignsFocus() {
		setupValidPasswordEntries()
		putFocusOn(.confirmPassword)
		XCTAssertTrue(sut.confirmPasswordTextField.isFirstResponder, "precondition")
		sut.submitButton.tap()
		XCTAssertFalse(sut.confirmPasswordTextField.isFirstResponder)
	}
	
	func test_tappingSubmit_withValidFields_shouldDisableCancelBarButton() {
		setupValidPasswordEntries()
		XCTAssertTrue(sut.cancelBarButton.isEnabled, "precondition")
		sut.submitButton.tap()
		XCTAssertFalse(sut.cancelBarButton.isEnabled)
	}
	
	func test_tappingSubmit_withValidFields_shouldShowBlurView() {
		setupValidPasswordEntries()
		XCTAssertNil(sut.blurView.superview, "precondition")
		sut.submitButton.tap()
		XCTAssertNotNil(sut.blurView.superview)
	}
	
	func test_tappingSubmit_withValidFields_shouldShowActivityIndicator() {
		setupValidPasswordEntries()
		XCTAssertNil(sut.activityIndicator.superview, "precondition")
		sut.submitButton.tap()
		XCTAssertNotNil(sut.activityIndicator.superview)
	}
	
	func test_tappingSubmit_withValidFields_shouldStartActivityAnimation() {
		setupValidPasswordEntries()
		XCTAssertFalse(sut.activityIndicator.isAnimating, "precondition")
		sut.submitButton.tap()
		XCTAssertTrue(sut.activityIndicator.isAnimating)
	}
	
	func test_tappingSubmit_withValidFields_shouldClearBackgroundColorForBlur() {
		setupValidPasswordEntries()
		XCTAssertNotEqual(sut.view.backgroundColor, .clear, "precondition")
		sut.submitButton.tap()
		XCTAssertEqual(sut.view.backgroundColor, .clear)
	}
	
	func test_tappingSubmit_withValidFields_shouldRequestChangePassword() {
		sut.securityToken = "TOKEN"
		sut.oldPasswordTextField.text = "OLD456"
		sut.newPasswordTextField.text = "NEW456"
		sut.confirmPasswordTextField.text = sut.newPasswordTextField.text
		sut.submitButton.tap()
		passwordChanger.verifyChange(
			securityToken: "TOKEN",
			oldPassword: "OLD456",
			newPassword: "NEW456")
	}
	
	func test_changePasswordSuccess_shouldStopActivityIndicatorAnimation() {
		setupValidPasswordEntries()
		sut.submitButton.tap()
		XCTAssertTrue(sut.activityIndicator.isAnimating, "precondition")
		passwordChanger.changeCallSuccess()
		XCTAssertFalse(sut.activityIndicator.isAnimating)
	}
	
	func test_changePasswordSuccess_shouldHideActivityIndicator() {
		setupValidPasswordEntries()
		sut.submitButton.tap()
		XCTAssertNotNil(sut.activityIndicator.superview, "precondition")
		passwordChanger.changeCallSuccess()
		XCTAssertNil(sut.activityIndicator.superview)
	}
	
	func test_changePasswordFailure_shouldStopActivityIndicatorAnimation() {
		setupValidPasswordEntries()
		sut.submitButton.tap()
		XCTAssertTrue(sut.activityIndicator.isAnimating, "precondition")
		passwordChanger.changeCallFailure(message: "DUMMY")
		XCTAssertFalse(sut.activityIndicator.isAnimating)
	}
	
	func test_changePasswordFailure_shouldHideActivityIndicator() {
		setupValidPasswordEntries()
		sut.submitButton.tap()
		XCTAssertNotNil(sut.activityIndicator.superview, "precondition")
		passwordChanger.changeCallFailure(message: "DUMMY")
		XCTAssertNil(sut.activityIndicator.superview)
	}
	
	func test_changePasswordSuccess_shouldShowSuccessAlert() {
		setupValidPasswordEntries()
		sut.submitButton.tap()
		passwordChanger.changeCallSuccess()
		verifyAlertPresented(message: "Your password has been successfully changed.")
	}
	
	func test_tappingOKInSuccessAlert_shouldDismissModal() throws {
		setupValidPasswordEntries()
		sut.submitButton.tap()
		passwordChanger.changeCallSuccess()
		let dismissalVerifier = DismissalVerifier()
		try alertVerifier.executeAction(forButton: "OK")
		dismissalVerifier.verify(animated: true, dismissedViewController: sut)
	}
	
	func test_changePasswordFailure_shouldShowFailureAlertWithGivenMessage() {
		setupValidPasswordEntries()
		sut.submitButton.tap()
		passwordChanger.changeCallFailure(message: "MESSAGE")
		verifyAlertPresented(message: "MESSAGE")
	}
	
	func test_tappingOKInFailureAlert_shouldClearAllFieldsToStartOver() throws {
		showPasswordChangeFailureAlert()
		try alertVerifier.executeAction(forButton: "OK")
		XCTAssertEqual(sut.oldPasswordTextField.text?.isEmpty, true, "old")
		XCTAssertEqual(sut.newPasswordTextField.text?.isEmpty, true, "new")
		XCTAssertEqual(sut.confirmPasswordTextField.text?.isEmpty, true, "confirmation")
	}
	
	func test_tappingOKInFailureAlert_shouldPutFocusOnOldPassword() throws {
		showPasswordChangeFailureAlert()
		putInViewHeirarachy(sut)
		try alertVerifier.executeAction(forButton: "OK")
		XCTAssertTrue(sut.oldPasswordTextField.isFirstResponder)
	}
	
	func test_tappingOKInFailureAlert_shouldSetBackgroundBackToWhite() throws {
		showPasswordChangeFailureAlert()
		XCTAssertNotEqual(sut.view.backgroundColor, .white, "precondition")
		try alertVerifier.executeAction(forButton: "OK")
		XCTAssertEqual(sut.view.backgroundColor, .white)
	}
	
	func test_tappingOKInFailureAlert_shouldHideBlur() throws {
		showPasswordChangeFailureAlert()
		XCTAssertNotNil(sut.blurView.superview, "precondition")
		try alertVerifier.executeAction(forButton: "OK")
		XCTAssertNil(sut.blurView.superview)
	}
	
	func test_tappingOKInFailureAlert_shouldEnableCancelBarButton() throws {
		showPasswordChangeFailureAlert()
		XCTAssertFalse(sut.cancelBarButton.isEnabled, "precondition")
		try alertVerifier.executeAction(forButton: "OK")
		XCTAssertTrue(sut.cancelBarButton.isEnabled)
	}
	
	func test_tappingOKInFailureAlert_shouldNotDismissModal() throws {
		showPasswordChangeFailureAlert()
		let dismissalVerifier = DismissalVerifier()
		try alertVerifier.executeAction(forButton: "OK")
		XCTAssertEqual(dismissalVerifier.dismissedCount, 0)
	}
	
	func test_textFieldDelegates_shouldBeConnected() {
		XCTAssertNotNil(sut.oldPasswordTextField.delegate, "oldPasswordTextField")
		XCTAssertNotNil(sut.newPasswordTextField.delegate, "newPasswordTextField")
		XCTAssertNotNil(sut.confirmPasswordTextField.delegate, "confirmPasswordTextField")
	}
	
	func test_hittingReturnFromOldPassword_shouldPutFocusOnNewPassword() {
		putInViewHeirarachy(sut)
		shouldReturn(in: sut.oldPasswordTextField)
		XCTAssertTrue(sut.newPasswordTextField.isFirstResponder)
	}
	
	func test_hittingReturnFromNewPassword_shouldPutFocusOnConfirmPassword() {
		putInViewHeirarachy(sut)
		shouldReturn(in: sut.newPasswordTextField)
		XCTAssertTrue(sut.confirmPasswordTextField.isFirstResponder)
	}
	
	func test_hittingReturnFromConfirmPassword_shouldRequestPasswordChange() {
		sut.securityToken = "TOKEN"
		sut.oldPasswordTextField.text = "OLD456"
		sut.newPasswordTextField.text = "NEW456"
		sut.confirmPasswordTextField.text = sut.newPasswordTextField.text
		shouldReturn(in: sut.confirmPasswordTextField)
		passwordChanger.verifyChange(
			securityToken: "TOKEN",
			oldPassword: "OLD456",
			newPassword: "NEW456"
		)
	}
	
	func test_hittingReturnFromOldPassword_shouldNotRequestPasswordChange() {
		setupValidPasswordEntries()
		shouldReturn(in: sut.oldPasswordTextField)
		passwordChanger.verifyChangeNeverCalled()
	}
	
	func test_hittingReturnFromNewPassword_shouldNotRequestPasswordChange() {
		setupValidPasswordEntries()
		shouldReturn(in: sut.newPasswordTextField)
		passwordChanger.verifyChangeNeverCalled()
	}
	
	override func tearDown() {
		executeRunLoop()
		sut = nil
		passwordChanger = nil
		alertVerifier = nil
		super.tearDown()
	}
	
	private func putFocusOn(_ inputFocus: InputFocus) {
		putInViewHeirarachy(sut)
		sut.updateInputFocus(inputFocus)
	}
	
	private func showPasswordChangeFailureAlert() {
		setupValidPasswordEntries()
		sut.submitButton.tap()
		passwordChanger.changeCallFailure(message: "DUMMY")
	}
	
	private func verifyAlertPresented(
		message: String,
		file: StaticString = #file,
		line: UInt = #line) {
		alertVerifier.verify(
			title: nil,
			message: message,
			animated: true,
			actions: [
				.default("OK")
			],
			presentingViewController: sut,
			file: file,
			line: line
		)
		XCTAssertEqual(alertVerifier.preferredAction?.title, "OK", "preferred Action", file: file, line: line)
	}
	
	private func setupValidPasswordEntries() {
		sut.oldPasswordTextField.text = "NONEMPTY"
		sut.newPasswordTextField.text = "123456"
		sut.confirmPasswordTextField.text = sut.newPasswordTextField.text
	}
	
	private func setupValidPasswordEntriesTooShort() {
		sut.oldPasswordTextField.text = "NONEMPTY"
		sut.newPasswordTextField.text = "12345"
		sut.confirmPasswordTextField.text = sut.newPasswordTextField.text
	}
	
	private func setupMismatchedConfirmationEntry() {
		sut.oldPasswordTextField.text = "NONEMPTY"
		sut.newPasswordTextField.text = "123456"
		sut.confirmPasswordTextField.text = "abcdef"
	}
}

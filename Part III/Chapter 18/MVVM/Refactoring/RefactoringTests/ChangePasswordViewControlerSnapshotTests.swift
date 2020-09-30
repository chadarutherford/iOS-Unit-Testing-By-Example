//
//  ChangePasswordViewControlerSnapshotTests.swift
//  RefactoringTests
//
//  Created by Chad Rutherford on 9/30/20.
//

import FBSnapshotTestCase
import XCTest
@testable import Refactoring

class ChangePasswordViewControlerSnapshotTests: FBSnapshotTestCase {
	
	private var sut: ChangePasswordViewController!
	private var passwordChanger: MockPasswordChanger!
	
	override func setUp() {
		super.setUp()
		recordMode = false
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewController(identifier: String(describing: ChangePasswordViewController.self))
		sut.viewModel = ChangePasswordViewModel(
			okButtonLabel: "OK",
			enterNewPasswordMessage: "Please enter a new password.",
			newPasswordTooShortMessage: "The new password should have at least 6 characters.",
			confirmationPasswordDoesNotMatchMessage: "The new password and the confirmation password don't match. Please try again.",
			successMessage: "Your password has been successfully changed."
		)
		passwordChanger = MockPasswordChanger()
		sut.passwordChanger = passwordChanger
		sut.loadViewIfNeeded()
	}
	
	func test_blur() {
		setupValidPasswordEntries()
		sut.submitButton.tap()
		verifySnapshot()
	}
	
	private func setupValidPasswordEntries() {
		sut.oldPasswordTextField.text = "NONEMPTY"
		sut.newPasswordTextField.text = "123456"
		sut.confirmPasswordTextField.text = sut.newPasswordTextField.text
	}
	
	private func verifySnapshot(file: StaticString = #file, line: UInt = #line) {
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.addSubview(sut.view)
		FBSnapshotVerifyViewController(sut, file: file, line: line)
	}
	
	override func tearDown() {
		executeRunLoop()
		sut = nil
		passwordChanger = nil
		super.tearDown()
	}
}

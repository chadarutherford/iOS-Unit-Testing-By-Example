//
//  ChangePasswordViewModel.swift
//  Refactoring
//
//  Created by Chad Rutherford on 9/30/20.
//

import Foundation

struct ChangePasswordViewModel {
	let okButtonLabel = "OK"
	let enterNewPasswordMessage = "Please enter a new password."
	let newPasswordTooShortMessage = "The new password should have at least 6 characters."
	let confirmationPasswordDoesNotMatchMessage = "The new password and the confirmation password don't match. Please try again."
	let successMessage = "Your password has been successfully changed."
	let title = "Change Password"
	let oldPasswordPlaceholder = "Current Password"
	let newPasswordPlaceholder = "New Password"
	let confirmPasswordPlaceholder = "Confirm New Password"
	let submitButtonLabel = "Submit"
	var inputFocus: InputFocus = .noKeyboard
	var isOldPasswordEmpty: Bool { oldPassword.isEmpty }
	var isNewPasswordEmpty: Bool { newPassword.isEmpty }
	var isNewPasswordTooShort: Bool { newPassword.count < 6 }
	var isConfirmPasswordMismatched: Bool { newPassword != confirmPassword }
	
	var oldPassword = ""
	var newPassword = ""
	var confirmPassword = ""
	
	enum InputFocus {
		case noKeyboard
		case oldPassword
		case newPassword
		case confirmPassword
	}
}

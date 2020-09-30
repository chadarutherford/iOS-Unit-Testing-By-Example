//
//  PasswordInputs.swift
//  Refactoring
//
//  Created by Chad Rutherford on 9/30/20.
//

import Foundation

struct PasswordInputs {
	var oldPassword: String
	var newPassword: String
	var confirmPassword: String
	var isOldPasswordEmpty: Bool { oldPassword.isEmpty }
	var isNewPasswordEmpty: Bool { newPassword.isEmpty }
	var isNewPasswordTooShort: Bool { newPassword.count < 6 }
	var isConfirmPasswordMismatched: Bool { newPassword != confirmPassword }
}

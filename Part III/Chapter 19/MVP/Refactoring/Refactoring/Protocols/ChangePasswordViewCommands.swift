//
//  ChangePasswordViewCommands.swift
//  Refactoring
//
//  Created by Chad Rutherford on 9/30/20.
//

import Foundation

protocol ChangePasswordViewCommands: AnyObject {
	func hideActivityIndicator()
	func showActivityIndicator()
	func showBlurView()
	func hideBlurView()
	func dismissModal()
	func setCancelButtonEnabled(_ enabled: Bool)
	func updateInputFocus(_ inputFocus: InputFocus)
	func showAlert(message: String, action: @escaping () -> Void)
}

enum InputFocus {
	case noKeyboard
	case oldPassword
	case newPassword
	case confirmPassword
}

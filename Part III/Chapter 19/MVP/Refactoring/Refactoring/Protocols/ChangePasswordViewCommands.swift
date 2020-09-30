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
	func showAlert(message: String, action: @escaping () -> Void)
}

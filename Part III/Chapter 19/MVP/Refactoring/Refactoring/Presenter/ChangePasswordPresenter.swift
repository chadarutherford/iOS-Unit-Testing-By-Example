//
//  ChangePasswordPresenter.swift
//  Refactoring
//
//  Created by Chad Rutherford on 9/30/20.
//

import Foundation

class ChangePasswordPresenter {
	
	private unowned var view: ChangePasswordViewCommands!
	private var viewModel: ChangePasswordViewModel
	private var securityToken: String
	private var passwordChanger: PasswordChanging!
	
	init(
		view: ChangePasswordViewCommands,
		viewModel: ChangePasswordViewModel,
		securityToken: String,
		passwordChanger: PasswordChanging) {
		self.view = view
		self.viewModel = viewModel
		self.securityToken = securityToken
		self.passwordChanger = passwordChanger
	}
	
	private func handleSuccess() {
		view.hideActivityIndicator()
		view.showAlert(message: viewModel.successMessage) { [weak self] in
			self?.view.dismissModal()
		}
	}
	
	private func startOver() {
		view.clearAllPasswordFields()
		view.updateInputFocus(.oldPassword)
		view.hideBlurView()
		view.setCancelButtonEnabled(true)
	}
	
	private func handleFailure(with message: String) {
		view.hideActivityIndicator()
		view.showAlert(message: message) { [weak self] in
			self?.startOver()
		}
	}
	
	func attemptToChangePassword() {
		passwordChanger.change(
			securityToken: securityToken,
			oldPassword: viewModel.oldPassword,
			newPassword: viewModel.newPassword) { [weak self] in
			self?.handleSuccess()
		} onFailure: { [weak self] message in
			self?.handleFailure(with: message)
		}
	}
	
	func setUpWaitingAppearance() {
		view.updateInputFocus(.noKeyboard)
		view.setCancelButtonEnabled(false)
		view.showBlurView()
		view.showActivityIndicator()
	}
	
	func resetNewPasswords() {
		view.clearNewPasswordFields()
		view.updateInputFocus(.newPassword)
	}
}

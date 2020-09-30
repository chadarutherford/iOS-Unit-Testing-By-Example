//
//  ChangePasswordViewController.swift
//  Refactoring
//
//  Created by Chad Rutherford on 9/29/20.
//

import UIKit

class ChangePasswordViewController: UIViewController {
	
	// --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	// MARK: - Outlets
	@IBOutlet private(set) weak var cancelBarButton: UIBarButtonItem!
	@IBOutlet private(set) weak var oldPasswordTextField: UITextField!
	@IBOutlet private(set) weak var newPasswordTextField: UITextField!
	@IBOutlet private(set) weak var confirmPasswordTextField: UITextField!
	@IBOutlet private(set) weak var submitButton: UIButton!
	@IBOutlet private(set) weak var navigationBar: UINavigationBar!
	
	// --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	// MARK: - Properties
	lazy var passwordChanger: PasswordChanging = PasswordChanger()
	var securityToken = ""
	private(set) var blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
	private(set) var activityIndicator = UIActivityIndicatorView(style: .large)
	private lazy var presenter = ChangePasswordPresenter(view: self, viewModel: viewModel)
	var viewModel: ChangePasswordViewModel! {
		didSet {
			guard isViewLoaded else { return }
			if oldValue.isCancelButtonEnabled != viewModel.isCancelButtonEnabled {
				cancelBarButton.isEnabled = viewModel.isCancelButtonEnabled
			}
			if oldValue.inputFocus != viewModel.inputFocus {
				updateInputFocus()
			}
			if oldValue.isBlurViewShowing != viewModel.isBlurViewShowing {
				updateBlurView()
			}
		}
	}
	
	// --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	// MARK: - View Controller Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		submitButton.layer.borderWidth = 1
		submitButton.layer.borderColor = UIColor(red: 55 / 255.0, green: 147 / 255.0, blue: 251 / 255.0, alpha: 1).cgColor
		submitButton.layer.cornerRadius = 8
		blurView.translatesAutoresizingMaskIntoConstraints = false
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		activityIndicator.color = .white
		setLabels()
	}
	
	// --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	// MARK: - Actions
	@IBAction private func cancel() {
		viewModel.inputFocus = .noKeyboard
		dismissModal()
	}
	
	@IBAction private func changePassword() {
		updateViewModelTextFields()
		guard validateInputs() else { return }
		setUpWaitingAppearance()
		attemptToChangePassword()
	}
	
	private func validateInputs() -> Bool {
		
		if viewModel.isOldPasswordEmpty {
			viewModel.inputFocus = .oldPassword
			return false
		}
		
		if viewModel.isNewPasswordEmpty {
			showAlert(message: viewModel.enterNewPasswordMessage) { [weak self] in
				self?.viewModel.inputFocus = .newPassword
			}
			return false
		}
		
		if viewModel.isNewPasswordTooShort {
			showAlert(message: viewModel.newPasswordTooShortMessage) { [weak self] in
				self?.resetNewPasswords()
			}
			return false
		}
		
		if viewModel.isConfirmPasswordMismatched {
			showAlert(message: viewModel.confirmationPasswordDoesNotMatchMessage) { [weak self] in
				self?.resetNewPasswords()
			}
			return false
		}
		return true
	}
	
	private func resetNewPasswords() {
		newPasswordTextField.text = ""
		confirmPasswordTextField.text = ""
		viewModel.inputFocus = .newPassword
	}
	private func setUpWaitingAppearance() {
		viewModel.inputFocus = .noKeyboard
		viewModel.isCancelButtonEnabled = false
		viewModel.isBlurViewShowing = true
		showActivityIndicator()
	}
	
	private func attemptToChangePassword() {
		passwordChanger.change(
			securityToken: securityToken,
			oldPassword: viewModel.oldPassword,
			newPassword: viewModel.newPassword) { [weak self] in
			self?.presenter.handleSuccess()
		} onFailure: { [weak self] message in
			self?.handleFailure(with: message)
		}
	}
	
	private func handleFailure(with message: String) {
		hideActivityIndicator()
		showAlert(message: message) { [weak self] in
			self?.startOver()
		}
	}
	
	private func startOver() {
		oldPasswordTextField.text = ""
		newPasswordTextField.text = ""
		confirmPasswordTextField.text = ""
		viewModel.inputFocus = .oldPassword
		viewModel.isBlurViewShowing = false
		viewModel.isCancelButtonEnabled = true
	}
	
	
	
	private func setLabels() {
		navigationBar.topItem?.title = viewModel.title
		oldPasswordTextField.placeholder = viewModel.oldPasswordPlaceholder
		newPasswordTextField.placeholder = viewModel.newPasswordPlaceholder
		confirmPasswordTextField.placeholder = viewModel.confirmPasswordPlaceholder
		submitButton.setTitle(viewModel.submitButtonLabel, for: .normal)
	}
	
	private func updateInputFocus() {
		switch viewModel.inputFocus {
		case .noKeyboard:
			view.endEditing(true)
		case .oldPassword:
			oldPasswordTextField.becomeFirstResponder()
		case .newPassword:
			newPasswordTextField.becomeFirstResponder()
		case .confirmPassword:
			confirmPasswordTextField.becomeFirstResponder()
		}
	}
	
	private func updateBlurView() {
		if viewModel.isBlurViewShowing {
			view.backgroundColor = .clear
			view.addSubview(blurView)
			NSLayoutConstraint.activate([
				blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
				blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
			])
		} else {
			view.backgroundColor = .white
			blurView.removeFromSuperview()
		}
	}
	
	private func updateViewModelTextFields() {
		viewModel.oldPassword = oldPasswordTextField.text ?? ""
		viewModel.newPassword = newPasswordTextField.text ?? ""
		viewModel.confirmPassword = confirmPasswordTextField.text ?? ""
	}
	
	
}

extension ChangePasswordViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == oldPasswordTextField {
			viewModel.inputFocus = .newPassword
		} else if textField == newPasswordTextField {
			viewModel.inputFocus = .confirmPassword
		} else if textField == confirmPasswordTextField {
			changePassword()
		}
		return true
	}
}

extension ChangePasswordViewController: ChangePasswordViewCommands {
	func showActivityIndicator() {
		view.addSubview(activityIndicator)
		NSLayoutConstraint.activate([
			activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
		activityIndicator.startAnimating()
	}
	
	func hideActivityIndicator() {
		activityIndicator.stopAnimating()
		activityIndicator.removeFromSuperview()
	}
	
	func dismissModal() {
		self.dismiss(animated: true)
	}
	
	private func showAlert(message: String, okAction: @escaping (UIAlertAction) -> Void) {
		let alertController = UIAlertController(
			title: nil,
			message: message,
			preferredStyle: .alert
		)
		let okButton = UIAlertAction(
			title: viewModel.okButtonLabel,
			style: .default,
			handler: okAction)
		alertController.addAction(okButton)
		alertController.preferredAction = okButton
		self.present(alertController, animated: true)
	}
	
	func showAlert(message: String, action: @escaping () -> Void) {
		let wrappedAction: (UIAlertAction) -> Void = { _ in
			action()
		}
		showAlert(message: message) { wrappedAction($0) }
	}
}

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
	private lazy var presenter = ChangePasswordPresenter(
		view: self,
		viewModel: viewModel,
		securityToken: securityToken,
		passwordChanger: passwordChanger)
	
	var viewModel: ChangePasswordViewModel!
	
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
		presenter.cancel()
	}
	
	@IBAction private func changePassword() {
		let passwordInputs = PasswordInputs(
			oldPassword: oldPasswordTextField.text ?? "",
			newPassword: newPasswordTextField.text ?? "",
			confirmPassword: confirmPasswordTextField.text ?? ""
		)
		presenter.changePassword(passwordInputs: passwordInputs)
	}
	
	private func setLabels() {
		navigationBar.topItem?.title = viewModel.title
		oldPasswordTextField.placeholder = viewModel.oldPasswordPlaceholder
		newPasswordTextField.placeholder = viewModel.newPasswordPlaceholder
		confirmPasswordTextField.placeholder = viewModel.confirmPasswordPlaceholder
		submitButton.setTitle(viewModel.submitButtonLabel, for: .normal)
	}
}

extension ChangePasswordViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == oldPasswordTextField {
			updateInputFocus(.newPassword)
		} else if textField == newPasswordTextField {
			updateInputFocus(.confirmPassword)
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
	
	func hideBlurView() {
		view.backgroundColor = .white
		blurView.removeFromSuperview()
	}
	
	func showBlurView() {
		view.backgroundColor = .clear
		view.addSubview(blurView)
		NSLayoutConstraint.activate([
			blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
			blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
		])
	}
	
	func dismissModal() {
		self.dismiss(animated: true)
	}
	
	func setCancelButtonEnabled(_ enabled: Bool) {
		cancelBarButton.isEnabled = enabled
	}
	
	func updateInputFocus(_ inputFocus: InputFocus) {
		switch inputFocus {
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
	
	func clearAllPasswordFields() {
		oldPasswordTextField.text = ""
		newPasswordTextField.text = ""
		confirmPasswordTextField.text = ""
	}
	
	func clearNewPasswordFields() {
		newPasswordTextField.text = ""
		confirmPasswordTextField.text = ""
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

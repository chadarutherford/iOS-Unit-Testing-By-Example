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
	var viewModel: ChangePasswordViewModel! {
		didSet {
			guard isViewLoaded else { return }
			if oldValue.isCancelButtonEnabled != viewModel.isCancelButtonEnabled {
				cancelBarButton.isEnabled = viewModel.isCancelButtonEnabled
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
		view.endEditing(true)
		dismiss(animated: true)
	}
	
	@IBAction private func changePassword() {
		guard validateInputs() else { return }
		setUpWaitingAppearance()
		attemptToChangePassword()
	}
	
	private func validateInputs() -> Bool {
		
		if oldPasswordTextField.text?.isEmpty ?? true {
			oldPasswordTextField.becomeFirstResponder()
			return false
		}
		
		if newPasswordTextField.text?.isEmpty ?? true {
			showAlert(message: viewModel.enterNewPasswordMessage) { [weak self] _ in
				self?.newPasswordTextField.becomeFirstResponder()
			}
			return false
		}
		
		if newPasswordTextField.text?.count ?? 0 < 6 {
			showAlert(message: viewModel.newPasswordTooShortMessage) { [weak self] _ in
				self?.resetNewPasswords()
			}
			return false
		}
		
		if newPasswordTextField.text != confirmPasswordTextField.text {
			showAlert(message: viewModel.confirmationPasswordDoesNotMatchMessage) { [weak self] _ in
				self?.resetNewPasswords()
			}
			return false
		}
		return true
	}
	
	private func resetNewPasswords() {
		newPasswordTextField.text = ""
		confirmPasswordTextField.text = ""
		newPasswordTextField.becomeFirstResponder()
	}
	private func setUpWaitingAppearance() {
		view.endEditing(true)
		viewModel.isCancelButtonEnabled = false
		view.backgroundColor = .clear
		view.addSubview(blurView)
		view.addSubview(activityIndicator)
		NSLayoutConstraint.activate([
			blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
			blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
			activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
		activityIndicator.startAnimating()
	}
	
	private func attemptToChangePassword() {
		passwordChanger.change(
			securityToken: securityToken,
			oldPassword: oldPasswordTextField.text ?? "",
			newPassword: newPasswordTextField.text ?? "") { [weak self] in
			self?.handleSuccess()
		} onFailure: { [weak self] message in
			self?.handleFailure(with: message)
		}
	}
	
	private func handleSuccess() {
		hideSpinner()
		showAlert(message: viewModel.successMessage) { [weak self] _ in
			self?.dismiss(animated: true)
		}
	}
	
	private func handleFailure(with message: String) {
		hideSpinner()
		showAlert(message: message) { [weak self] _ in
			self?.startOver()
		}
	}
	
	private func startOver() {
		oldPasswordTextField.text = ""
		newPasswordTextField.text = ""
		confirmPasswordTextField.text = ""
		oldPasswordTextField.becomeFirstResponder()
		view.backgroundColor = .white
		blurView.removeFromSuperview()
		viewModel.isCancelButtonEnabled = true
	}
	
	private func hideSpinner() {
		activityIndicator.stopAnimating()
		activityIndicator.removeFromSuperview()
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
			newPasswordTextField.becomeFirstResponder()
		} else if textField == newPasswordTextField {
			confirmPasswordTextField.becomeFirstResponder()
		} else if textField == confirmPasswordTextField {
			changePassword()
		}
		return true
	}
}

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
	}
	
	// --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	// MARK: - Actions
	@IBAction private func cancel() {
		oldPasswordTextField.resignFirstResponder()
		newPasswordTextField.resignFirstResponder()
		confirmPasswordTextField.resignFirstResponder()
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
			showAlert(message: "Please enter a new password.") { [weak self] _ in
				self?.newPasswordTextField.becomeFirstResponder()
			}
			return false
		}
		
		if newPasswordTextField.text?.count ?? 0 < 6 {
			showAlert(message: "The new password should have at least 6 characters.") { [weak self] _ in
				self?.newPasswordTextField.text = ""
				self?.confirmPasswordTextField.text = ""
				self?.newPasswordTextField.becomeFirstResponder()
			}
			return false
		}
		
		if newPasswordTextField.text != confirmPasswordTextField.text {
			showAlert(message: "The new password and the confirmation password don't match. Please try again.") { [weak self] _ in
				self?.newPasswordTextField.text = ""
				self?.confirmPasswordTextField.text = ""
				self?.newPasswordTextField.becomeFirstResponder()
			}
			return false
		}
		return true
	}
	
	private func setUpWaitingAppearance() {
		oldPasswordTextField.resignFirstResponder()
		newPasswordTextField.resignFirstResponder()
		confirmPasswordTextField.resignFirstResponder()
		cancelBarButton.isEnabled = false
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
			self?.activityIndicator.stopAnimating()
			self?.activityIndicator.removeFromSuperview()
			self?.showAlert(message: "Your password has been successfully changed.") { [weak self] _ in
				self?.dismiss(animated: true)
			}
		} onFailure: { [weak self] message in
			self?.activityIndicator.stopAnimating()
			self?.activityIndicator.removeFromSuperview()
			self?.showAlert(message: message) { [weak self] _ in
				self?.oldPasswordTextField.text = ""
				self?.newPasswordTextField.text = ""
				self?.confirmPasswordTextField.text = ""
				self?.oldPasswordTextField.becomeFirstResponder()
				self?.view.backgroundColor = .white
				self?.blurView.removeFromSuperview()
				self?.cancelBarButton.isEnabled = true
			}
		}
	}
	
	private func showAlert(message: String, okAction: @escaping (UIAlertAction) -> Void) {
		let alertController = UIAlertController(
			title: nil,
			message: message,
			preferredStyle: .alert
		)
		let okButton = UIAlertAction(
			title: "OK",
			style: .default,
			handler: okAction)
		alertController.addAction(okButton)
		alertController.preferredAction = okButton
		self.present(alertController, animated: true)
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

//
//  ViewController.swift
//  Refactoring
//
//  Created by Chad Rutherford on 9/29/20.
//

import UIKit

class ViewController: UIViewController {
	
	// --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	// MARK: - View Controller Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	// --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		switch segue.identifier {
		case "changePassword":
			let changePasswordVC = segue.destination as? ChangePasswordViewController
			changePasswordVC?.securityToken = "TOKEN"
			changePasswordVC?.viewModel = ChangePasswordViewModel(
				okButtonLabel: "OK",
				enterNewPasswordMessage: "Please enter a new password.",
				newPasswordTooShortMessage: "The new password should have at least 6 characters.",
				confirmationPasswordDoesNotMatchMessage: "The new password and the confirmation password don't match. Please try again.",
				successMessage: "Your password has been successfully changed."
			)
		default:
			break
		}
	}
}

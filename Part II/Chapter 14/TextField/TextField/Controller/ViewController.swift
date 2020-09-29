//
//  ViewController.swift
//  TextField
//
//  Created by Chad Rutherford on 9/25/20.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet private(set) weak var userNameField: UITextField!
	@IBOutlet private(set) weak var passwordField: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	deinit {
		print(">> View Controller deinit")
	}
	
	private func performLogin(username: String, password: String) {
		print("Username: \(username)")
		print("Password: \(password)")
	}
}

extension ViewController: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if textField == userNameField {
			return !string.contains(" ")
		} else {
			return true
		}
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == userNameField {
			passwordField.becomeFirstResponder()
		} else {
			guard let username = userNameField.text,
				  let password = passwordField.text else { return false }
			passwordField.resignFirstResponder()
			performLogin(username: username, password: password)
		}
		return false
	}
}

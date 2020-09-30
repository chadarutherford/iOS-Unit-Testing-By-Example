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
		default:
			break
		}
	}
}

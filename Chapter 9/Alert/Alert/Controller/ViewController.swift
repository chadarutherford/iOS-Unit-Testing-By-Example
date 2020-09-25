//
//  ViewController.swift
//  Alert
//
//  Created by Chad Rutherford on 9/24/20.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet private(set) weak var button: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@IBAction private func buttonTapped(_ sender: UIButton) {
		let alert = UIAlertController(
			title: "Do the Thing?",
			message: "Let us know if you want to do the thing",
			preferredStyle: .alert
		)
		
		let cancelAction = UIAlertAction(
							title: "Cancel",
							style: .cancel) { _ in print(">> Cancel") }
		
		let okAction = UIAlertAction(
							title: "OK",
							style: .default) { _ in print(">> OK") }
		
		alert.addAction(cancelAction)
		alert.addAction(okAction)
		alert.preferredAction = okAction
		present(alert, animated: true)
	}
}

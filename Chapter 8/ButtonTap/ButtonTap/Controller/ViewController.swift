//
//  ViewController.swift
//  ButtonTap
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
		print(">> Button was tapped")
	}
}

//
//  ViewController.swift
//  Navigation
//
//  Created by Chad Rutherford on 9/25/20.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet private(set) weak var codePushButton: UIButton!
	@IBOutlet private(set) weak var codeModalButton: UIButton!
	@IBOutlet private(set) weak var seguePushButton: UIButton!
	@IBOutlet private(set) weak var segueModalButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@IBAction func codePushTapped(_ sender: UIButton) {
		let nextVC = CodeNextViewController(labelText: "Pushed from code")
		self.navigationController?.pushViewController(nextVC, animated: true)
	}
	
	@IBAction func codeModalTapped(_ sender: UIButton) {
		let nextVC = CodeNextViewController(labelText: "Modal from code")
		present(nextVC, animated: true)
	}
	
	@IBAction func seguePushTapped(_ sender: UIButton) {
		
	}
	
	@IBAction func segueModalTapped(_ sender: UIButton) {
		
	}
}

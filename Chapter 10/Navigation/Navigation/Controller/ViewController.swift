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
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		switch segue.identifier {
		case SegueNextViewController.pushIdentifier:
			guard let nextVC = segue.destination as? SegueNextViewController else { return }
			nextVC.labelText = "Pushed from segue"
		case SegueNextViewController.modalIdentifier:
			guard let nextVC = segue.destination as? SegueNextViewController else { return }
			nextVC.labelText = "Modal from segue"
		default:
			return
		}
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

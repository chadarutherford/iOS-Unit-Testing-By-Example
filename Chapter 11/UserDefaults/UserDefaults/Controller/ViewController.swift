//
//  ViewController.swift
//  UserDefaults
//
//  Created by Chad Rutherford on 9/25/20.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet private(set) weak var counterLabel: UILabel!
	@IBOutlet private(set) weak var incrementButton: UIButton!
	
	private var count = 0 {
		didSet {
			counterLabel.text = "\(count)"
			UserDefaults.standard.set(count, forKey: "count")
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		count = UserDefaults.standard.integer(forKey: "count")
	}
	
	@IBAction private func incrementButtonTapped(_ sender: UIButton) {
		count += 1
	}
}

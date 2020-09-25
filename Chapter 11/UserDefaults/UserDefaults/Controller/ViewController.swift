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
	
	var userDefaults: UserDefaultsProtocol = UserDefaults.standard
	private var count = 0 {
		didSet {
			counterLabel.text = "\(count)"
			userDefaults.set(count, forKey: "count")
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		count = userDefaults.integer(forKey: "count")
	}
	
	@IBAction private func incrementButtonTapped(_ sender: UIButton) {
		count += 1
	}
}

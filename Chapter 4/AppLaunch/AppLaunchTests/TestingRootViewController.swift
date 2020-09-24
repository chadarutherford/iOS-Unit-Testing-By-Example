//
//  TestingRootViewController.swift
//  AppLaunchTests
//
//  Created by Chad Rutherford on 9/24/20.
//

import UIKit

class TestingRootViewController: UIViewController {
	
	override func loadView() {
		let label = UILabel()
		label.text = "Running Tests...."
		label.textAlignment = .center
		label.textColor = .white	
		view = label
	}
}

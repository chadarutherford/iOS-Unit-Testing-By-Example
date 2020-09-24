//
//  ViewController.swift
//  HardDependencies
//
//  Created by Chad Rutherford on 9/24/20.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		Analytics.shared.track(event: "viewDidAppear - \(type(of: self))")
	}
}

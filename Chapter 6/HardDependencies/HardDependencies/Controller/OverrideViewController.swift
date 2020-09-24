//
//  OverrideViewController.swift
//  HardDependencies
//
//  Created by Chad Rutherford on 9/24/20.
//

import UIKit

class OverrideViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	func analytics() -> Analytics {
		Analytics.shared
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		analytics().track(event: "viewDidAppear - \(type(of: self))")
	}
}

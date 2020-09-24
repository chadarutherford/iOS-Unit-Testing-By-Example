//
//  MySingletonViewController.swift
//  HardDependencies
//
//  Created by Chad Rutherford on 9/24/20.
//

import UIKit

class MySingletonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		MySingletonAnalytics.shared.track(event: "viewDidAppear - \(type(of: self))")
	}
}

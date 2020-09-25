//
//  SegueNextViewController.swift
//  Navigation
//
//  Created by Chad Rutherford on 9/25/20.
//

protocol ReuseIdentifiable {
	static var pushIdentifier: String { get }
	static var modalIdentifier: String { get }
}

import UIKit

class SegueNextViewController: UIViewController {
	@IBOutlet private(set) weak var label: UILabel!
	
	var labelText: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		label.text = labelText
	}
	
	deinit {
		print(">> SegueNextViewController deinit")
	}
}

extension SegueNextViewController: ReuseIdentifiable {
	static var pushIdentifier: String {
		"\(String(describing: Self.self))Push"
	}
	
	static var modalIdentifier: String {
		"\(String(describing: Self.self))Modal"
	}
}

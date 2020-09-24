//
//  CodeBasedViewController.swift
//  LoadViewControllersProg
//
//  Created by Chad Rutherford on 9/24/20.
//

import UIKit

class CodeBasedViewController: UIViewController {
	private let data: String
	
	init(data: String) {
		self.data = data
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print(">> Create views here:")
	}
}

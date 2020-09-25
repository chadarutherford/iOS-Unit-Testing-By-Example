//
//  TestingHelpers.swift
//  AlertTests
//
//  Created by Chad Rutherford on 9/24/20.
//

import UIKit

extension UIButton {
	func tap() {
		self.sendActions(for: .touchUpInside)
	}
}

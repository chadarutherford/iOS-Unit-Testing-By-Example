//
//  TestHelpers.swift
//  ButtonTapTests
//
//  Created by Chad Rutherford on 9/24/20.
//

import UIKit

extension UIButton {
	func tap() {
		self.sendActions(for: .touchUpInside)
	}
}

extension UIBarButtonItem {
	func tap() {
		_ = self.target?.perform(self.action, with: nil)
	}
}

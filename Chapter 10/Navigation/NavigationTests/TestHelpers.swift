//
//  TestHelpers.swift
//  NavigationTests
//
//  Created by Chad Rutherford on 9/25/20.
//

import UIKit

extension UIButton {
	func tap() {
		self.sendActions(for: .touchUpInside)
	}
}

func executeRunLoop() {
	RunLoop.current.run(until: Date())
}

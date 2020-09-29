//
//  ViewControllerSnapshotTests.swift
//  SnapshotTests
//
//  Created by Chad Rutherford on 9/29/20.
//

import FBSnapshotTestCase
@testable import Snapshot

class ViewControllerSnapshotTests: FBSnapshotTestCase {
	
	override func setUp() {
		super.setUp()
		recordMode = false
	}
	
	func test_example() {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
		FBSnapshotVerifyViewController(sut)
	}
}

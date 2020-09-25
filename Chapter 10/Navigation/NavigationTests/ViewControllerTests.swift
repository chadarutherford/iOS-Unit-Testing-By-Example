//
//  ViewControllerTests.swift
//  NavigationTests
//
//  Created by Chad Rutherford on 9/25/20.
//

import ViewControllerPresentationSpy
import XCTest
@testable import Navigation

class ViewControllerTests: XCTestCase {
	
	private var sut: ViewController!
	private var presentationVerifier: PresentationVerifier!
	
	override func setUp() {
		super.setUp()
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
		sut.loadViewIfNeeded()
		presentationVerifier = PresentationVerifier()
	}
	
	func test_tappingCodePushButton_shouldPushCodeNextViewController() {
		let navigation = UINavigationController(rootViewController: sut)
		sut.codePushButton.tap()
		executeRunLoop()
		XCTAssertEqual(navigation.viewControllers.count, 2, "navigation stack")
		let pushedVC = navigation.viewControllers.last
		guard let codeNextVC = pushedVC as? CodeNextViewController else {
			XCTFail("Expected CodeNextViewController, "
						+ "but was \(String(describing: pushedVC))")
			return
		}
		XCTAssertEqual(codeNextVC.label.text, "Pushed from code")
	}
	
//	func test_INCORRECT_tappingCodeModalButton_shouldPresentCodeNextViewController() {
//		UIApplication.shared.windows.first?.rootViewController = sut
//		sut.codeModalButton.tap()
//		let presentedVC = sut.presentedViewController
//		guard let codeNextVC = presentedVC as? CodeNextViewController else {
//			XCTFail("Expected CodeNextViewController, "
//						+ "but was \(String(describing: presentedVC))")
//			return
//		}
//		XCTAssertEqual(codeNextVC.label.text, "Modal from code")
//	}
	
	func test_tappingCodeModalButton_shouldPresentCodeNextViewController() {
		UIApplication.shared.windows.first?.rootViewController = sut
		sut.codeModalButton.tap()
		let codeNextVC: CodeNextViewController? = presentationVerifier.verify(
			animated: true,
			presentingViewController: sut
		)
		XCTAssertEqual(codeNextVC?.label.text, "Modal from code")
	}
	
	func test_tappingSeguePushButton_shouldShowSegueNextViewController() {
		sut.putInWindow()
		sut.seguePushButton.tap()
		let segueNextVC: SegueNextViewController? = presentationVerifier.verify(
			animated: true,
			presentingViewController: sut
		)
		XCTAssertEqual(segueNextVC?.label.text, "Pushed from segue")
	}
	
	func test_tappingSegueModalButton_shouldShowSegueNextViewController() {
		sut.segueModalButton.tap()
		let segueNextVC: SegueNextViewController? = presentationVerifier.verify(
			animated: true,
			presentingViewController: sut
		)
		XCTAssertEqual(segueNextVC?.label.text, "Modal from segue")
	}
	
	override func tearDown() {
		executeRunLoop()
		sut = nil
		presentationVerifier = nil
		super.tearDown()
	}
	
	// We can't use this for a view controller that comes from a storyboard
//	private class TestableViewController: ViewController {
//		var presentCallCount = 0
//		var presentArgsViewController: [UIViewController] = []
//		var presentArgsAnimated: [Bool] = []
//		var presentArgsClosure: [(() -> Void)?] = []
//
//		override func present(
//			_ viewControllerToPresent: UIViewController,
//			animated flag: Bool,
//			completion: (() -> Void)? = nil) {
//			presentCallCount += 1
//			presentArgsViewController.append(viewControllerToPresent)
//			presentArgsAnimated.append(flag)
//			presentArgsClosure.append(completion)
//		}
//	}
}

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
	
	func test_tappingCodePushButton_shouldPushCodeNextViewController() {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
		sut.loadViewIfNeeded()
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
	
	func test_INCORRECT_tappingCodeModalButton_shouldPresentCodeNextViewController() {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
		sut.loadViewIfNeeded()
		UIApplication.shared.windows.first?.rootViewController = sut
		sut.codeModalButton.tap()
		let presentedVC = sut.presentedViewController
		guard let codeNextVC = presentedVC as? CodeNextViewController else {
			XCTFail("Expected CodeNextViewController, "
						+ "but was \(String(describing: presentedVC))")
			return
		}
		XCTAssertEqual(codeNextVC.label.text, "Modal from code")
	}
	
	func test_tappingCodeModalButton_shouldPresentCodeNextViewController() {
		let presentationVerifier = PresentationVerifier()
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
		sut.loadViewIfNeeded()
		UIApplication.shared.windows.first?.rootViewController = sut
		sut.codeModalButton.tap()
		let codeNextVC: CodeNextViewController? = presentationVerifier.verify(
			animated: true,
			presentingViewController: sut
		)
		XCTAssertEqual(codeNextVC?.label.text, "Modal from code")
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

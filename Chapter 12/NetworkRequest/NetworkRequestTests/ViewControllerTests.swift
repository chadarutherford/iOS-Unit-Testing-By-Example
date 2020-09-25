//
//  ViewControllerTests.swift
//  NetworkRequestTests
//
//  Created by Chad Rutherford on 9/25/20.
//

import XCTest
@testable import NetworkRequest

class ViewControllerTests: XCTestCase {
	
	private var sut: ViewController!
	private var session: MockURLSession!

    override func setUpWithError() throws {
		super.setUp()
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
		session = MockURLSession()
		sut.session = session
    }
	
	func test_tappingButton_shouldMakeDataTaskToSearchForEBookOutFromBoneville() {
		sut.loadViewIfNeeded()
		sut.button.tap()
		XCTAssertEqual(session.dataTaskCallCount, 1, "call count")
		XCTAssertEqual(session.dataTaskArgsRequest.first, URLRequest(url: URL(string: "https://itunes.apple.com/search?media=ebook&term=out%20from%20boneville")!), "request")
	}

    override func tearDownWithError() throws {
        sut = nil
		super.tearDown()
    }
}

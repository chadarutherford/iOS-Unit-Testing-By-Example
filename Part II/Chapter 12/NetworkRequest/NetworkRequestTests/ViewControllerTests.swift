//
//  ViewControllerTests.swift
//  NetworkRequestTests
//
//  Created by Chad Rutherford on 9/25/20.
//

import ViewControllerPresentationSpy
import XCTest
@testable import NetworkRequest

class ViewControllerTests: XCTestCase {
	
	private var alertVerifier: AlertVerifier!
	private var sut: ViewController!
	private var session: MockURLSession!

    override func setUpWithError() throws {
		super.setUp()
		alertVerifier = AlertVerifier()
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
		session = MockURLSession()
		sut.session = session
    }
	
	func test_tappingButton_shouldMakeDataTaskToSearchForEBookOutFromBoneville() {
		sut.loadViewIfNeeded()
		sut.button.tap()
		session.verifyDataTask(with: URLRequest(url: URL(string: "https://itunes.apple.com/search?media=ebook&term=out%20from%20boneville")!))
	}
	
	func test_searchForBookNetworkCall_withSuccessResponse_shouldSaveDataInResults() {
		sut.loadViewIfNeeded()
		sut.button.tap()
		let handleResultsCalled = expectation(description: "handleResultsCalled")
		sut.handleResults = { _ in
			handleResultsCalled.fulfill()
		}
		session.dataTaskArgsCompletionHandler.first?(
			jsonData(), response(statusCode: 200), nil
		)
		waitForExpectations(timeout: 0.01)
		XCTAssertEqual(sut.results, [SearchResult(artistName: "Artist", trackName: "Track", averageUserRating: 2.5, genres: ["Foo", "Bar"])])
	}
	
	func test_searchForBookNetworkCall_withSuccessBeforeAsync_shouldNotSaveDataInResults() {
		sut.loadViewIfNeeded()
		sut.button.tap()
		session.dataTaskArgsCompletionHandler.first?(
			jsonData(), response(statusCode: 200), nil
		)
		XCTAssertEqual(sut.results, [])
	}
	
	func test_searchForBookNetworkCall_withError_shouldShowAlert() {
		sut.loadViewIfNeeded()
		sut.button.tap()
		let alertShown = expectation(description: "alertShown")
		alertVerifier.testCompletion = {
			alertShown.fulfill()
		}
		session.dataTaskArgsCompletionHandler.first?(
			nil, nil, TestError(message: "oh no")
		)
		waitForExpectations(timeout: 0.01)
		verifyErrorAlert(message: "oh no")
	}
	
	func test_searchForBookNetworkCall_withErrorPreAsync_shouldNotShowAlert() {
		sut.loadViewIfNeeded()
		sut.button.tap()
		session.dataTaskArgsCompletionHandler.first?(
			nil, nil, TestError(message: "DUMMY")
		)
		XCTAssertEqual(alertVerifier.presentedCount, 0)
	}

    override func tearDown() {
        sut = nil
		alertVerifier = nil
		session = nil
		super.tearDown()
    }
	
	private func response(statusCode: Int) -> HTTPURLResponse? {
		HTTPURLResponse(url: URL(string: "http://DUMMY")!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
	}
	
	private func verifyErrorAlert(
		message: String,
		file: StaticString = #file,
		line: UInt = #line) {
		alertVerifier.verify(
			title: "Network Problem",
			message: message,
			animated: true,
			actions: [
				.default("Ok")
			],
			presentingViewController: sut,
			file: file,
			line: line
		)
		XCTAssertEqual(alertVerifier.preferredAction?.title, "Ok", "preferred action", file: file, line: line)
	}
}

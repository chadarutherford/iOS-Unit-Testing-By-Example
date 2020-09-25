//
//  ViewController.swift
//  NetworkRequest
//
//  Created by Chad Rutherford on 9/25/20.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet private(set) weak var button: UIButton!
	
	var session: URLSessionProtocol = URLSession.shared
	var handleResults: ([SearchResult]) -> Void = { print($0) }
	private var dataTask: URLSessionDataTask?
	private(set) var results = [SearchResult]() {
		didSet {
			handleResults(results)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	private func searchForBook(terms: String) {
		guard let encodedTerms = terms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
			  let url = URL(string: "https://itunes.apple.com/search?"
								+ "media=ebook&term=\(encodedTerms)") else { return }
		let request = URLRequest(url: url)
		dataTask = session.dataTask(with: request) { [weak self] data, response, error in
			guard let self = self else { return }
			var decoded: Search?
			var errorMessage: String?
			if let error = error {
				errorMessage = error.localizedDescription
			} else if let response = response as? HTTPURLResponse,
					  response.statusCode != 200 {
				errorMessage = "Response: \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))"
			} else if let data = data {
				do {
					decoded = try JSONDecoder().decode(Search.self, from: data)
				} catch {
					errorMessage = error.localizedDescription
				}
			}
			
			DispatchQueue.main.async {
				if let decoded = decoded {
					self.results = decoded.results
				}
				if let errorMessage = errorMessage {
					self.showError(errorMessage)
				}
				self.dataTask = nil
				self.button.isEnabled = true
			}
		}
		button.isEnabled = false
		dataTask?.resume()
	}
	
	private func showError(_ message: String) {
		let title = "Network Problem"
		print("\(title): \(message)")
		let alert = UIAlertController(
			title: title,
			message: message,
			preferredStyle: .alert
		)
		let okAction = UIAlertAction(
			title: "Ok",
			style: .default
		)
		alert.addAction(okAction)
		alert.preferredAction = okAction
		present(alert, animated: true)
	}
	
	@IBAction private func buttonTapped(_ sender: UIButton) {
		searchForBook(terms: "out from boneville")
	}
}

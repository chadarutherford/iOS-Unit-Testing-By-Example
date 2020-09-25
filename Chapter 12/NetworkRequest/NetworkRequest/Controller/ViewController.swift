//
//  ViewController.swift
//  NetworkRequest
//
//  Created by Chad Rutherford on 9/25/20.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet private(set) weak var button: UIButton!
	
	private var dataTask: URLSessionDataTask?

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	private func searchForBook(terms: String) {
		guard let encodedTerms = terms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
			  let url = URL(string: "https://itunes.apple.com/search?"
								+ "media=ebook&term=\(encodedTerms)") else { return }
		let request = URLRequest(url: url)
		dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
			guard let self = self else { return }
			let decoded = String(data: data ?? Data(), encoding: .utf8)
			print("response: \(String(describing: response))")
			print("data: \(String(describing: decoded))")
			print("error: \(String(describing: error))")
			
			DispatchQueue.main.async { [weak self] in
				guard let self = self else { return }
				self.dataTask = nil
				self.button.isEnabled = true
			}
		}
		button.isEnabled = false
		dataTask?.resume()
	}
	
	@IBAction private func buttonTapped(_ sender: UIButton) {
		searchForBook(terms: "out from boneville")
	}
}
